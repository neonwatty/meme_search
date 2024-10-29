from transformers import AutoModelForCausalLM, AutoTokenizer
from PIL import Image
import transformers

# turn down transformers verbose logs
transformers.logging.set_verbosity_error()

# model identifiers
model_id = "vikhyatk/moondream2"
revision = "2024-08-26"


def image_to_text(image_path: str) -> str:
    try:
        print(f"STARTING: image_to_text extraction of image --> {image_path}")
        prompt = "Describe this image, including any text you see on the image."

        # instantiate model and tokenizer
        model = AutoModelForCausalLM.from_pretrained(
            model_id,
            trust_remote_code=True,
            revision=revision,
        )
        tokenizer = AutoTokenizer.from_pretrained(model_id, revision=revision)
        
        # load in image
        image = Image.open(image_path)
        
        # process image
        enc_image = model.encode_image(image)
        description = model.answer_question(enc_image, prompt, tokenizer)
        print(f"DONE: image_to_text extraction of image --> {image_path}")

        return description
    except Exception as e:
        error_msg = f"FAILURE: image_to_text extraction of image --> {image_path} failed with exception --> {e}"
        print(error_msg)
        raise e

