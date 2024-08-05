# TabbyAPI

<p align="left">
    <img src="https://img.shields.io/badge/Python-3.10%20|%203.11%20|%203.12-blue" alt="Python 3.10, 3.11, and 3.12">
    <a href="/LICENSE">
        <img src="https://img.shields.io/badge/License-AGPLv3-blue.svg" alt="License: AGPL v3"/>
    </a>
    <a href="https://discord.gg/sYQxnuD7Fj">
        <img src="https://img.shields.io/discord/545740643247456267.svg?logo=discord&color=blue" alt="Discord Server"/>
    </a>
</p>

<p align="left">
    <a href="https://theroyallab.github.io/tabbyAPI">
        <img src="https://img.shields.io/badge/Documentation-API-orange" alt="Developer facing API documentation">
    </a>
</p>

<p align="left">
    <a href="https://ko-fi.com/I2I3BDTSW">
        <img src="https://img.shields.io/badge/Support_on_Ko--fi-FF5E5B?logo=ko-fi&style=for-the-badge&logoColor=white" alt="Support on Ko-Fi">
    </a>
</p>

> [!IMPORTANT]
>
>  In addition to the README, please read the [Wiki](https://github.com/theroyallab/tabbyAPI/wiki/1.-Getting-Started) page for information about getting started!

> [!NOTE]
> 
>  Need help? Join the [Discord Server](https://discord.gg/sYQxnuD7Fj) and get the `Tabby` role. Please be nice when asking questions.

A FastAPI based application that allows for generating text using an LLM (large language model) using the [Exllamav2 backend](https://github.com/turboderp/exllamav2)

TabbyAPI is also the official API backend server for ExllamaV2.

## Disclaimer

This project is marked as rolling release. There may be bugs and changes down the line. Please be aware that you might need to reinstall dependencies if needed.

TabbyAPI is a hobby project made for a small amount of users. It is not meant to run on production servers. For that, please look at other solutions that support those workloads.

## Supported Model Types

TabbyAPI uses Exllamav2 as a powerful and fast backend for model inference, loading, etc. Therefore, the following types of models are supported:

- Exl2 (Highly recommended)

- GPTQ

- FP16 (using Exllamav2's loader)

In addition, TabbyAPI supports parallel batching using paged attention for Nvidia Ampere GPUs and higher.

#### Alternative Loaders/Backends

If you want to use a different model type or quantization method than the ones listed above, here are some alternative backends with their own APIs:

- GGUF + GGML - [KoboldCPP](https://github.com/lostruins/KoboldCPP)

- Production ready + Many other quants + batching - [Aphrodite Engine](https://github.com/PygmalionAI/Aphrodite-engine)

- Production ready + batching - [VLLM](https://github.com/vllm-project/vllm)

- [Text Generation WebUI](https://github.com/oobabooga/text-generation-webui)

## Getting Started

### Choose Models

Find the model you want on [huggingface models](https://huggingface.co/models) with exl2 quantization. For example: `bartowski/Qwen2-7B-Instruct-exl2`

### Build and Run Service Using Docker

Edit the variables in `docker.sh` file.
```
MODEL_NAME=bartowski/Qwen2-7B-Instruct-exl2 -> repo name
REVISION=6_5                                -> the specific model version to use (quantization bits in this case)
TAG=qwen2-7b                                -> docker image tag
PORT=5000                                   -> exposed port
```

Build service
```bash
bash docker.sh build
```

Run service
```bash
bash docker.sh start
```

Stop service
```bash
docker stop llm_onprem
```

### Test Service using Curl

Example:
```bash
curl http://127.0.0.1:5000/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
     "model": "test",
     "messages": [{"role": "user", "content": "Say this is a test!"}],
     "temperature": 0.7
   }'
```

## Contributing

Use the template when creating issues or pull requests, otherwise the developers may not look at your post.

If you have issues with the project:

- Describe the issue in detail

- If you have a feature request, please indicate it as such.

If you have a Pull Request

- Describe the pull request in detail, what, and why you are changing something

## Acknowldgements

TabbyAPI would not exist without the work of other contributors and FOSS projects:

- [ExllamaV2](https://github.com/turboderp/exllamav2)
- [Aphrodite Engine](https://github.com/PygmalionAI/Aphrodite-engine)
- [infinity-emb](https://github.com/michaelfeil/infinity)
- [FastAPI](https://github.com/fastapi/fastapi)
- [Text Generation WebUI](https://github.com/oobabooga/text-generation-webui)
- [SillyTavern](https://github.com/SillyTavern/SillyTavern)

## Developers and Permissions

Creators/Developers:

- [kingbri](https://github.com/bdashore3)

- [Splice86](https://github.com/Splice86)

- [Turboderp](https://github.com/turboderp)
