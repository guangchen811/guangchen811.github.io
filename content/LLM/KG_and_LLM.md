---
title: "[DRAFT]: Language + Knowledge: The Mutual Reinforcement of Large Language Models and Knowledge Graphs"
date: 2023-04-23
draft: false
tags: 
- LLMs
- knowledge graph
---

# introduction

LLM has show great success in many NLP tasks, including question answering, text generation, and so on. However, LLMs are still far from human-level intelligence. However, the accuaracy, consistency and explainability of LLMs block the application of LLMs in many real-world scenarios. To address these problems, researchers have proposed many methods to improve the mentioned abilities of LLMs. One of the most promising methods is to combine LLMs with knowledge graphs, which is a high-quality structured knowledge source with reasonable explainability. On the other hand, LLMs can also be used to improve the quality of knowledge graphs. In this blog, we will introduce the mutual reinforcement of LLMs and knowledge graphs.

# Basic Concepts

## Knowledge Graph

In the domain of knowledge representation and reasoning, a knowledge graph is a type of knowledge base that utilizes a graph-structured data model or topology to integrate data. Knowledge graphs are often utilized to store interconnected descriptions of entities, including objects, events, situations, or abstract concepts, while simultaneously encoding the underlying semantics of the terminology utilized.

<div align="center">
    <img src="/images/LLM_KG/google_search_capture.png" alt="google search" height=200>
    <figcaption align="center">The search results of "Sam Altman" on Google. Some of the search results, like Age and Parents, are from knowledge graph.
</figcaption>
</div>

The concept of a knowledge graph was initially introduced by Google in 2012. Google's knowledge graph functions as a knowledge base to augment their search engine's search results with semantic-search information that is sourced from a diverse range of origins. Knowledge graphs are also employed by corporations such as Amazon, Facebook, and Microsoft, amongst others.

[This blog](https://towardsdatascience.com/a-guide-to-the-knowledge-graphs-bfb5c40272f1) make a good introduction to knowledge graph. Building a knowledge graph is a very difficult task. The main steps can be summarized in this [repo](https://github.com/husthuke/awesome-knowledge-graph). the main steps can be summarized in the following figure.

<div align="center">
    <img src="/images/LLM_KG/KG_building_process.svg" alt="Image 2" height=300>
    <figcaption align="center">The process of building a knowledge graph is relatively complex and involves multiple stages from data cleaning and pre-processing, to entity and relationship extraction, to knowledge fusion and storage. Building a knowledge graph requires a significant amount of human and material resources, but it greatly improves efficiency and accuracy in knowledge management and data integration.
</figcaption>
</div>

## Language Model

In contrast to knowledge graphs, large language models (LLMs) utilize neural networks to model knowledge, which is a type of implicit knowledge. One of the most renowned LLMs is the GPT series, which is a transformer-based language model. Figure  illustrates the training process of the GPT series.

The GPT series has reached several milestones, with GPT-3, InstructGPT, and ChatGPT being among the most significant. With a large corpus and unsupervised learning, GPT-3 is capable of generating human-like text. To enhance GPT's ability to adhere to instructions, InstructGPT was developed, which employs supervised learning with human-labelled context following the instructions, and uses RLHF to generate text that is more favorable. ChatGPT, on the other hand, was designed to improve GPT's ability to converse with humans. ChatGPT employs a similar approach to InstructGPT, but is intended to produce text that is more like human conversation.

<div align="center">
    <img src="/images/LLM_KG/gpt_process.svg" alt="gpt_process" width=2000>
    <figcaption align="center"> training process of GPT series.
</figcaption>
</div>

While the GPT series has achieved considerable success in numerous NLP tasks, it still experiences several issues that can prove challenging to address. Some of these problems can be attributed to the training methods utilized by the model.

For instance, while the utilization of a large corpus has benefitted the GPT series, it has also resulted in the acquisition of biases contained in the corpus, leading to the model experiencing low consistency and a higher likelihood of producing fake-looking contexts that may appear correct.

In addition, the supervised learning approach used by InstructGPT and ChatGPT is not immune to bias, as the diverse backgrounds of the labelers may impact the model's general behavior, making it hard to detect and mitigate. A well-known example of such an occurrence is observed in the case of [Behavior Cloning](https://www.alignmentforum.org/posts/BgoKdAzogxmgkuuAt/behavior-cloning-is-miscalibrated).

# combination of LLMs and KGs

## How can KGs help LLMs?

It is evident that high-quality knowledge graphs (KGs) can assist LLMs in achieving better accuracy, consistency, and explainability. However, how can this idea be implemented? In this section, we will discuss two methods: KGs as training data and KGs as part of the prompt.

One straightforward approach is to utilize KGs as training data. However, as a language model, the GPT series can only accept text as input, necessitating the conversion of KGs to text format. Google proposed a model called TekGen in [this paper](https://arxiv.org/abs/2010.12688), which converts KGs to text. The underlying workings of TekGen are depicted in the figure below.

<div align="center">
    <img src="/images/LLM_KG/graph_to_text.png" alt="graph_to_text" height=300>
    <figcaption align="center">Overall training process of TekGen.</figcaption>
</div>


With the help of TekGen, we can convert KGs to text and use them as training data no matter at pre-training stage or fine-tuning stage. However I don't think this methodology is the best way to leverage KGs. Although Knowledge graphs are high-quality knowledge source. The scale is limited to change the distribution of the training dataset. So the effect of this method is limited. Besides, KGs are structured data with high explainability. But after converting to text, we send the explainability of KGs into black box.

<div align="center">
    <img src="/images/LLM_KG/toolformer_graph_toolformer.png" alt="Image 9" height=300>
    <figcaption align="center">The overall working principle of this project.</figcaption>
</div>

Another method is to use KGs as part of prompt. In another word, we can use KGs as a tool of LLMs to generate text. This methodology become popular as [Toolformer](https://arxiv.org/abs/2302.04761) published. The main idea of Toolformer is to tuning LLMs have the ability to generate API queries. Different tools can be leverage to implement different functions following the queries and return the results to LLMs. Inspired by this idea, [Graph Toolformer](https://github.com/jwzhanggy/Graph_Toolformer/tree/main/%E4%B8%AD%E6%96%87%E4%BB%8B%E7%BB%8D) implemented rich API templates to help LLMs handle graph-related tasks.

The Toolformer framework need tuning LLMs which is hard to be implemented. We can also make it easier by asking LLMs writing SQL to interact with graph database directly. For example, [This project](https://medium.com/neo4j/context-aware-knowledge-graph-chatbot-with-gpt-4-and-neo4j-d3a99e8ae21e) leverage GPT-4 to generate Cypher queries to interact with a neo4j database which contains knowledge about movies. With few efferot, we can make a chatbot which can recommend movies to users.

## How can LLMs help KGs?

Although high-quality knowledge graphs can help LLMs. The high-quality knowledge graphs are hard to build. So, reverse thinking, can LLMs help KGs? The answer is yes. In this section, we will discuss two methods: LLMs act as a knowledge graph and LLMs as a tool to build knowledge graph.

<div align="center">
    <img src="/images/LLM_KG/LLM_to_KG_illustration.svg" alt="Image 4" height=200>
    <figcaption align="center">LLM_gen_KG_illustration</figcaption>
</div>

The first method is to use LLMs as a knowledge graph. As we discussed before, LLMs itself contains a lot of knowledge. So can we use LLMs as a knowledge graph directly? [This paper](https://arxiv.org/pdf/2204.06031.pdf) has make a comprehensive discussion what abilities LLMs should have to act as a knowledge graph which is summarized in the following figure.

<div align="center">
    <img src="/images/LLM_KG/LLM_as_KG_illustration.svg" alt="Image 4" height=300>
    <figcaption align="center">LLM_as_KG_illustration</figcaption>
</div>

<div align="center">
    <img src="/images/LLM_KG/LLM_as_KG.png" alt="Image 4" height=600>
    <figcaption align="center">The abilities LLMs should have to act as a knowledge graph.</figcaption>
</div>

It is not hard to find out that nowadays LLMs still have a long way to go to act as a knowledge graph. But it is still a promising direction. The early attempt are listed in the following table but I will not discuss them in detail.

The other method is to use LLMs as a tool to build knowledge graph. This method is more practical and has been implemented by many projects.

For example, [this project](https://github.com/tomhartke/knowledge-graph-from-GPT-3) use GPT-3 to generate triples from QA pairs. The overall working principle of this project is shown in the following figure.

<div align="center">
    <img src="/images/LLM_KG/GPT3_KG.png" alt="Image 5" height=400>
    <figcaption align="center">The overall working principle of this project.</figcaption>
</div>

After chatGPT proposed, this technology become more popular. Some [Zero-shot method](https://arxiv.org/abs/2302.10205) claim that Chat-format prompt are more effective than vanilla prompt. The famous package [Langchain](langchain.com) also implement related functions to extract triples from plain text. I'm really amazed by the power of [Prompt Engineering](https://lilianweng.github.io/posts/2023-03-15-prompt-engineering/) when I use LangChain and I recommend you to try this package to unlock the power of LLMs. Based on LangChain, [Kor](https://github.com/eyurtsev/kor) implement a pipeline to extract entities and relations from plain text. All we need to do is to provide concrete descriptions of entities and relations.

<div align="center">
    <img src="/images/LLM_KG/LLM_gen_KG_from_text.svg" alt="Image 5" height=300>
    <figcaption align="center">The overall working principle of this project.</figcaption>
</div>

There are also brief implementations which we can paly with online. [GraphGPT](https://graphgpt.vercel.app/) is a demo which can extract triples from plain text. After providing your OpenAI API key, you can play with it. The following figure shows the result of extracting triples from a sentence.



# Summarization

KGs and LLMs are two ways to represent knowledge. They have their own advantages and disadvantages. In this article, we discussed how to leverage KGs to help LLMs and how to leverage LLMs to help KGs. Although there are many problems to be solved, I believe that the combination of KGs and LLMs will bring us more surprises in the future.

# References

[1] Hogan, Aidan, et al. "Knowledge graphs." ACM Computing Surveys (CSUR) 54.4 (2021): 1-37.