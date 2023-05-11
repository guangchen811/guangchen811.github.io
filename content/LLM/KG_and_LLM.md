---
title: "Language + Knowledge: The Mutual Reinforcement of Large Language Models and Knowledge Graphs"
date: 2023-04-23
draft: true
tags: 
- LLMs
- knowledge graph
---

# introduction

LLM has show great success in many NLP tasks, including question answering, text generation, and so on. However, LLMs are still far from human-level intelligence. However, the accuaracy, consistency and explainability of LLMs block the application of LLMs in many real-world scenarios. To address these problems, researchers have proposed many methods to improve the mentioned abilities of LLMs. One of the most promising methods is to combine LLMs with knowledge graphs, which is a high-quality structured knowledge source with reasonable explainability. On the other hand, LLMs can also be used to improve the quality of knowledge graphs. In this blog, we will introduce the mutual reinforcement of LLMs and knowledge graphs.

# Basic Concepts

## Knowledge Graph

In knowledge representation and reasoning, knowledge graph is a knowledge base that uses a graph-structured data model or topology to integrate data. Knowledge graphs are often used to store interlinked descriptions of entities – objects, events, situations or abstract concepts – while also encoding the semantics underlying the used terminology.

<div align="center">
    <img src="/images/LLM_KG/bing_workflow.svg" alt="Image 1" height=300>
    <figcaption align="center">Overall working principle of New Bing.</figcaption>
</div>


The concept of knowledge graph was first proposed by Google in 2012. Google's knowledge graph is a knowledge base used by Google to enhance its search engine's search results with semantic-search information gathered from a wide variety of sources. Knowledge graphs are also used by Amazon, Facebook, Microsoft, and other companies.

[This blog](https://towardsdatascience.com/a-guide-to-the-knowledge-graphs-bfb5c40272f1) make a good introduction to knowledge graph.

Building a knowledge graph is a very difficult task. The main steps can be summarized in this [repo](https://github.com/husthuke/awesome-knowledge-graph). the main steps can be summarized in the following figure.

<div align="center">
    <img src="/images/LLM_KG/KG_building_stages.svg" alt="Image 1" height=300>
    <figcaption align="center">The main steps to build a knowledge graph. 知识图谱的构建过程是一个相对复杂的过程，需要跨越从数据清洗和预处理到实体和关系提取，再到知识融合、知识存储多个阶段的处理。构建知识图谱的过程需要耗费大量人力和物力，但是对于提高知识管理和数据整合的效率和精度都有极大的帮助。
</figcaption>
</div>

## Language Model

Different from Knowledge graph, Large language model using neural network to model knowledge, which is a kind of implicit knowledge. The most famous LLM is GPT series, which is a transformer-based language model. The training process of GPT series is shown in the following figure.

As my knowledge, the most important milestones of GPT series are GPT-3, InstructGPT, and ChatGPT. Based on large corpus and unsupervised learning, GPT-3 can generate human-like text. To improve the ability of GPT to follow instructions, InstructGPT is proposed. InstructGPT using supervised learning with human-labelled context which follows the instruction. and RLHF to make the generated text's more preferable. Similar to InstructGPT, ChatGPT is proposed to improve the ability of GPT to chat with human. ChatGPT using similar method as InstructGPT, but the purpose is to make the generated text more like human's chat.

<div align="center">
    <img src="/images/LLM_KG/gpt_process.svg" alt="Image 1" height=300>
    <figcaption align="center"> training process of GPT series.
</figcaption>
</div>

Although GPT series has achieved great success in many NLP tasks, it still has many problems. Some of this problems are caused by the training methods themselves which can be hard to solve. 

On the one hand, although GPT get a lot benefits from the large corpus, the bias contained by large corpus are also captured which make it suffering from low consistency and risk of telling fake context looks right.

On the other hand, the supervised learning method used by InstructGPT and ChatGPT also cantain bais from labelers' diverse background. The distribution of labelers may affect the general behavior of the model which is hard to detect and solve. A famous case is [Behavior Cloning](https://www.alignmentforum.org/posts/BgoKdAzogxmgkuuAt/behavior-cloning-is-miscalibrated).

# combination of LLMs and KGs

## How can KGs help LLMs?

It's obvious that high-quality knowledge graphs can help LLMs to improve the accuracy, consistency and explainability. But how can we implement this idea? In this section, we will discuss two methods: KGs as training data and KGs as part of prompt.

One strightforward method is to use KGs as training data. However, as a language model, GPT series can only use text as input. So we need to convert KGs to text. [This paper](https://arxiv.org/abs/2010.12688) by google proposed a model namely TekGen, which can convert KGs to text. The overall working principle of TekGen is shown in the following figure.

<div align="center">
    <img src="/images/LLM_KG/tekgen.svg" alt="Image 1" height=300>
    <figcaption align="center">Overall working principle of TekGen.</figcaption>
</div>


With the help of TekGen, we can convert KGs to text and use them as training data no matter at pre-training stage or fine-tuning stage. However I don't think this methodology is the best way to leverage KGs. Although Knowledge graphs are high-quality knowledge source. The scale is limited to change the distribution of the training dataset. So the effect of this method is limited. Besides, KGs are structured data with high explainability. But after converting to text, we send the explainability of KGs into black box.

Another method is to use KGs as part of prompt. In another word, we can use KGs as a tool of LLMs to generate text. This methodology become popular as [Toolformer](https://arxiv.org/abs/2302.04761) published. The main idea of Toolformer is to tuning LLMs have the ability to generate API queries. Different tools can be leverage to implement different functions following the queries and return the results to LLMs. Inspired by this idea, [Graph Toolformer](https://github.com/jwzhanggy/Graph_Toolformer/tree/main/%E4%B8%AD%E6%96%87%E4%BB%8B%E7%BB%8D) implemented rich API templates to help LLMs handle graph-related tasks.

The Toolformer framework need tuning LLMs which is hard to be implemented. We can also make it easier by asking LLMs writing SQL to interact with graph database directly. For example, [This project](https://medium.com/neo4j/context-aware-knowledge-graph-chatbot-with-gpt-4-and-neo4j-d3a99e8ae21e) leverage GPT-4 to generate Cypher queries to interact with a neo4j database which contains knowledge about movies. With few efferot, we can make a chatbot which can recommend movies to users.

## How can LLMs help KGs?

Although high-quality knowledge graphs can help LLMs. The high-quality knowledge graphs are hard to build. So, reverse thinking, can LLMs help KGs? The answer is yes. In this section, we will discuss two methods: LLMs act as a knowledge graph and LLMs as a tool to build knowledge graph.

The first method is to use LLMs as a knowledge graph. As we discussed before, LLMs itself contains a lot of knowledge. So can we use LLMs as a knowledge graph directly? [This paper](https://arxiv.org/pdf/2204.06031.pdf) has make a comprehensive discussion what abilities LLMs should have to act as a knowledge graph which is summarized in the following figure.

<div align="center">
    <img src="/images/LLM_KG/LLM_KG.svg" alt="Image 1" height=300>
    <figcaption align="center">The abilities LLMs should have to act as a knowledge graph.</figcaption>
</div>

It is not hard to find out that nowadays LLMs still have a long way to go to act as a knowledge graph. But it is still a promising direction. The early attempt are listed in the following table but I will not discuss them in detail.

The other method is to use LLMs as a tool to build knowledge graph. This method is more practical and has been implemented by many projects.

For example, [this project](https://github.com/tomhartke/knowledge-graph-from-GPT-3) use GPT-3 to generate triples from QA pairs. The overall working principle of this project is shown in the following figure.

<div align="center">
    <img src="/images/LLM_KG/gpt3_kg.svg" alt="Image 1" height=300>
    <figcaption align="center">The overall working principle of this project.</figcaption>
</div>

After chatGPT proposed, this technology become more popular. Some [Zero-shot method](https://arxiv.org/abs/2302.10205) claim that Chat-format prompt are more effective than vanilla prompt. The famous package [Langchain](langchain.com) also implement related functions to extract triples from plain text. I'm really amazed by the power of [Prompt Engineering](https://lilianweng.github.io/posts/2023-03-15-prompt-engineering/) when I use LangChain and I recommend you to try this package to unlock the power of LLMs. Based on LangChain, [Kor](https://github.com/eyurtsev/kor) implement a pipeline to extract entities and relations from plain text. All we need to do is to provide concrete descriptions of entities and relations.

There are also brief implementations which we can paly with online. [GraphGPT](https://graphgpt.vercel.app/) is a demo which can extract triples from plain text. After providing your OpenAI API key, you can play with it. The following figure shows the result of extracting triples from a sentence.

# summarization

KGs and LLMs are two ways to represent knowledge. They have their own advantages and disadvantages. In this article, we discussed how to leverage KGs to help LLMs and how to leverage LLMs to help KGs. Although there are many problems to be solved, I believe that the combination of KGs and LLMs will bring us more surprises in the future.

# reference

[1] Hogan, Aidan, et al. "Knowledge graphs." ACM Computing Surveys (CSUR) 54.4 (2021): 1-37.