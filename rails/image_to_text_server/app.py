from fastapi import FastAPI
from pydantic import BaseModel
import json
import os
import time
import threading
import logging
import requests

app = FastAPI()
lock = threading.Lock()

# constants
APP_URL = 'http://host.docker.internal:3000/image_cores/receiver'        
QUEUE_FILE = 'job_queue.json'


# configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')


# initialize the job queue
if not os.path.exists(QUEUE_FILE):
    with open(QUEUE_FILE, 'w') as f:
        json.dump([], f)


# model for received jobs
class Job(BaseModel):
    image_core_id: int
    image_path: str


def send_result(output_job_details: dict) -> dict:
    try:
        response = requests.post(APP_URL, json=output_job_details)
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
    time.sleep(5)
    
    # create return payload
    output_job_details = {
        "image_core_id": input_job_details["image_core_id"],
        "description": "this is a test"
    }
    return output_job_details


def process_jobs():
    while True:
        with lock:
            with open(QUEUE_FILE, 'r+') as f:
                jobs = json.load(f)
                if jobs:
                    # Process the first job
                    input_job_details = jobs.pop(0)
                    logging.info("Processing job: %s", input_job_details)
                    
                    # process job
                    output_job_details = proccess_job(input_job_details)
                    
                    # send results to main app
                    response = send_result(output_job_details)
                    logging.info(f"response from send --> {response}")
                                    
                    # log completion
                    logging.info("Finished processing job: %s", input_job_details)
                    
                    # Write back the updated queue
                    f.seek(0)
                    json.dump(jobs, f)
                    f.truncate()
                else:
                    # If there are no jobs, wait for a while before checking again
                    logging.info("No jobs in queue. Waiting...")
                    time.sleep(5)


@app.post('/add_job')
def add_job(job: Job):
    logging.info(f"job info --> {job}")
    with open(QUEUE_FILE, 'r+') as f:
        jobs = json.load(f)
        jobs.append(job.dict())
        f.seek(0)
        json.dump(jobs, f)
        f.truncate()
    
    logging.info("Job added to queue: %s", job)
    return {"status": "Job added to queue"}


@app.get('/')
def home():
    logging.info("HELLO WORLD")

        
if __name__ == '__main__':
    # Start the job processing thread
    threading.Thread(target=process_jobs, daemon=True).start()
    
    # Run the FastAPI app
    import uvicorn
    uvicorn.run(app, host='0.0.0.0', port=8000)
