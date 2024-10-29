from fastapi import FastAPI
from pydantic import BaseModel
import sqlite3
import time
import threading
import logging
import requests
from pathlib import Path
from image_to_text_generator import image_to_text

app = FastAPI()
lock = threading.Lock()

# constants
APP_URL = 'http://host.docker.internal:3000/image_cores/receiver'        
JOB_DB = 'job_queue.db'


# initialize table
def init_db():
    conn = sqlite3.connect(JOB_DB)
    cursor = conn.cursor()
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS jobs (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            image_core_id INTEGER,
            image_path TEXT NOT NULL
        )
    ''')
    conn.commit()
    conn.close()

# configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')


# model for received jobs
class Job(BaseModel):
    image_core_id: int
    image_path: str


def send_result(output_job_details: dict) -> dict:
    try:
        response = requests.post(APP_URL, json={"data": output_job_details})
        if response.status_code == 200:
            print(response.json()) 
            return {"data": "SUCCESS: item queued"}
        else:
            print(f'Error: {response.status_code}')
            return {"data": "FAILURE: item not queued"}
    except Exception as e:
        failure_message = f"FAILURE: queue failed with exception {e}"
        print(failure_message)
        return {"data": failure_message}


def proccess_job(input_job_details: dict) -> dict:
    # simulate job processing
    # time.sleep(2)
    
    # Specify the file path
    # file_path = Path(input_job_details["image_path"])

    # # Get the size of the file in bytes
    # file_size = file_path.stat().st_size
    # logging.info(f"SIZE OF TEST FILE --> {file_size}")
    
    description = image_to_text(input_job_details["image_path"])
    
    # create return payload
    output_job_details = {
        "image_core_id": input_job_details["image_core_id"],
        "description": description
    }
    return output_job_details


def process_jobs():
    while True:
        with lock:
            conn = sqlite3.connect(JOB_DB)
            cursor = conn.cursor()
            
            cursor.execute('SELECT * FROM jobs ORDER BY id LIMIT 1')
            job = cursor.fetchone()
            
            if job:
                job_id, image_core_id, image_path = job
                input_job_details = {"image_core_id": image_core_id, "image_path": "/public/" + image_path}

                logging.info("Processing job: %s", input_job_details)
                
                # process job
                output_job_details = proccess_job(input_job_details)
                
                # send results to main app
                response = send_result(output_job_details)
                logging.info(f"response from send --> {response}")
                                
                # log completion
                logging.info("Finished processing job: %s", input_job_details)
                
                # Remove the processed job from the queue
                cursor.execute('DELETE FROM jobs WHERE id = ?', (job_id,))
                conn.commit()
            else:
                # If there are no jobs, wait for a while before checking again
                logging.info("No jobs in queue. Waiting...")
                time.sleep(5)


@app.post('/add_job')
def add_job(job: Job):
    conn = sqlite3.connect(JOB_DB)
    cursor = conn.cursor()
    
    cursor.execute('INSERT INTO jobs (image_core_id, image_path) VALUES (?, ?)', (job.image_core_id, job.image_path))
    conn.commit()
    conn.close()
    
    logging.info("Job added to queue: %s", job)
    return {"status": "Job added to queue"}


@app.get('/')
def home():
    logging.info("HELLO WORLD")

        
if __name__ == '__main__':
    # Initialize the database
    init_db()
    
    # Start the job processing thread
    threading.Thread(target=process_jobs, daemon=True).start()
    
    # Run the FastAPI app
    import uvicorn
    uvicorn.run(app, host='0.0.0.0', port=8000)
