from llama_cpp import Llama

llm = Llama(model_path="../models/llama-2-7b-chat.Q6_K.gguf", n_gqa=8, n_gpu_layers=43, main_gpu=1)
output = llm("Q: Name the planets in the solar system? A: ", max_tokens=32, stop=["Q:", "\n"], echo=True)
print(output)
