from transformers import AutoModelForCausalLM, AutoTokenizer

import logging

logging.basicConfig(
    level=logging.DEBUG, format="%(asctime)s - %(levelname)s - %(message)s"
)

# model identifiers
model_id = "vikhyatk/moondream2"
revision = "2024-08-26"

# instantiate model and tokenizer
logging.info("INFO: instantiating model...")
model = AutoModelForCausalLM.from_pretrained(
    model_id, trust_remote_code=True, revision=revision
)
logging.info("INFO:... complete")
logging.info("INFO: instantiating tokenizer...")
tokenizer = AutoTokenizer.from_pretrained(model_id, revision=revision)
logging.info("...complete")

if __name__ == "__main__":
    logging.info("INFO: calling to download model")
