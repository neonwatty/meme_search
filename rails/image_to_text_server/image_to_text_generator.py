from transformers import AutoModelForCausalLM, AutoTokenizer
from PIL import Image
import transformers

transformers.logging.set_verbosity_error()


def prompt_moondream(img_path: str, prompt: str) -> str:
    # copied from moondream demo readme --> https://github.com/vikhyat/moondream/tree/main
    model_id = "vikhyatk/moondream2"
    revision = "2024-05-20"
    model = AutoModelForCausalLM.from_pretrained(
        model_id,
        trust_remote_code=True,
        revision=revision,
    )
    tokenizer = AutoTokenizer.from_pretrained(model_id, revision=revision)
    image = Image.open(img_path)
    enc_image = model.encode_image(image)
    moondream_response = model.answer_question(enc_image, prompt, tokenizer)
    return moondream_response


def image_to_text(image_path: str) -> str:
    try:
        print("STARTING: image_to_text extr")
        prompt = "Describe this image."

        print(f"INFO: prompting moondream for a description of image: '{image_path}'")
        answer = prompt_moondream(image_path, prompt)
        return answer
    except Exception as e:
        print(f"FAILURE: image_to_text failed with exception {e}")
        raise e
