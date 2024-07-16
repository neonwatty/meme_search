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


def extract_text_from_imgs(img_paths: list) -> list:
    try:
        print("STARTING: extract_text_from_imgs")
        prompt = "Describe this image."
        answers = []
        for img_path in img_paths:
            print(f"INFO: prompting moondream for a description of image: '{img_path}'")
            answer = prompt_moondream(img_path, prompt)
            answers.append(answer)
            print("DONE!")
        print("SUCCESS: extract_text_from_imgs succeeded")
        return answers
    except Exception as e:
        print(f"FAILURE: extract_text_from_imgs failed with exception {e}")
        raise e
