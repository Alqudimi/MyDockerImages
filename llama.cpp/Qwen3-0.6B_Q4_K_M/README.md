# Qwen3-0.6B Q4_K_M on llama.cpp

هذا المشروع يبني صورة Docker ذاتية الاكتفاء تشغّل `Qwen3-0.6B-Q4_K_M.gguf` عبر `llama-server`، وتوفّر واجهات OpenAI-compatible على المنفذ `8080`.

## التشغيل

```bash
docker compose up -d --build
curl http://127.0.0.1:8080/health
curl http://127.0.0.1:8080/v1/models
```

اختبار المحادثة:

```bash
curl http://127.0.0.1:8080/v1/chat/completions \\
  -H 'Content-Type: application/json' \\
  -H 'Authorization: Bearer sk-local' \\
  -d '{
    "model": "Qwen3-0.6B-Q4_K_M.gguf",
    "messages": [{"role": "user", "content": "قل مرحباً بالعربية في جملة قصيرة."}],
    "temperature": 0.2,
    "max_tokens": 64,
    "stream": false
  }'
```

يعمل أيضًا مع مكتبة OpenAI:

```python
from openai import OpenAI

client = OpenAI(
    base_url="http://127.0.0.1:8080/v1",
    api_key="sk-local",
)
response = client.chat.completions.create(
    model="Qwen3-0.6B-Q4_K_M.gguf",
    messages=[{"role": "user", "content": "Hello"}],
    max_tokens=64,
)
print(response.choices[0].message.content)
```

> النموذج مرخّص تحت Apache-2.0 وفق بطاقة النموذج على Hugging Face. راجع شروط استخدام النموذج قبل النشر العام.
