from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import json
import os
import time
import threading
import logging
import requests

app = FastAPI()
queue_file = 'job_queue.json'

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Initialize the job queue
if not os.path.exists(queue_file):
    with open(queue_file, 'w') as f:
        json.dump([], f)

class Job(BaseModel):
    job_name: str
    image_path: str
    

def process_job(job_details):
    # simulate job processing
    time.sleep(5)
    
    # return success or failure message to main host
    try:
        url = 'http://host.docker.internal:3000/receive'
        response = requests.get(url)
        if response.status_code == 200:
            print(response.json())  # For JSON response
            return {"status": "SUCCESS: item queued"}
        else:
            print(f'Error: {response.status_code}')
            return {"status": "FAILURE: item not queued"}
    except Exception as e:
        failure_message = f"FAILURE: queue failed with exception {e}"
        print(failure_message)
        return {"status": failure_message}
    
    return


def process_jobs():
    while True:
        with open(queue_file, 'r+') as f:
            jobs = json.load(f)
            if jobs:
                # Process the first job
                job = jobs.pop(0)
                logging.info("Processing job: %s", job)
                
                # Process job
                process_job(job)
                                
                # log completion
                logging.info("Finished processing job: %s", job)
                
                # Write back the updated queue
                f.seek(0)
                json.dump(jobs, f)
                f.truncate()
            else:
                # If there are no jobs, wait for a while before checking again
                logging.info("No jobs in queue. Waiting...")
                time.sleep(5)


@app.get('/')
def home():
    try:
        url = 'http://host.docker.internal:3000/image_cores/receiver'
        
        # Define any data you want to send in the POST request
        data = {"key": "value"}  # Replace with your actual data

        response = requests.post(url, json=data)  # Use json parameter to send JSON data
        print(response)
        
        if response.status_code == 200:
            print(response.json())  # For JSON response
            return {"data": "SUCCESS: item queued"}
        else:
            print(f'Error: {response.status_code}')
            return {"data": "FAILURE: item not queued"}
    except Exception as e:
        failure_message = f"FAILURE: queue failed with exception {e}"
        print(failure_message)
        return {"data": failure_message}


@app.post('/enqueue')
def enqueue_job(job: Job):
    with open(queue_file, 'r+') as f:
        jobs = json.load(f)
        jobs.append(job.dict())
        f.seek(0)
        json.dump(jobs, f)
        f.truncate()
    
    logging.info("Job added to queue: %s", job)
    return {"status": "Job added to queue"}


if __name__ == '__main__':
    # Start the job processing thread
    threading.Thread(target=process_jobs, daemon=True).start()
    
    # Run the FastAPI app
    import uvicorn
    uvicorn.run(app, host='0.0.0.0', port=8000)
