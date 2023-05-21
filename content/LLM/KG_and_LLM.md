---
title: "[DRAFT]: Language + Knowledge: The Mutual Reinforcement of Large Language Models and Knowledge Graphs"
date: 2023-04-23
draft: false
tags: 
- LLMs
- knowledge graph
---

Large language models (LLMs) has show great success in many NLP tasks, including question answering, text generation, and so on. However, the accuaracy, consistency and explainability of LLMs still block the application of LLMs in many real-world scenarios. To address these problems, researchers have proposed many methods to improve the mentioned abilities of LLMs. One of the most promising methods is to combine LLMs with knowledge graphs (KGs), which is a high-quality structured knowledge source with reasonable explainability. On the other hand, LLMs can also be used to improve the quality of knowledge graphs. In this blog, we will discuss the mutual reinforcement of LLMs and KGs.

# Basic Concepts

## Knowledge Graph

In simple terms, a knowledge graph is a way of organizing and representing information in a structured format. It consists of a collection of interconnected nodes and edges, where each node represents a specific entity or concept, and each edge represents a relationship between those entities or concepts.

Think of a knowledge graph as a visual representation of knowledge, where entities are represented as nodes (also known as vertices) and relationships between entities are represented as edges (also known as links). For example, in a knowledge graph about movies, nodes could represent actors, directors, movies, and genres, while edges could represent relationships such as "acted in," "directed," or "belongs to genre."

The power of a knowledge graph lies in its ability to capture and represent complex relationships between different entities. It allows you to connect the dots between different pieces of information and provides a framework for understanding how things are related.

<div align="center">
    <img src="/images/LLM_KG/google_search_capture.png" alt="google search" height=200>
    <figcaption align="center">The search results of "Sam Altman" on Google. Some of the search results, like Age and Parents, are from knowledge graph.
</figcaption>
</div>

Knowledge graphs are commonly used in various applications, such as search engines, recommendation systems, and virtual assistants. The concept of a knowledge graph was initially introduced by Google in 2012. Google's knowledge graph functions as a knowledge base to augment their search engine's search results with semantic-search information that is sourced from a diverse range of origins. To know more about the conceptions, advantages and use cases, please check [this blog](https://towardsdatascience.com/a-guide-to-the-knowledge-graphs-bfb5c40272f1). 

It's a systemical and dirty process to build a high-quality knowledge, the main steps can be summarized in this [repo](https://github.com/husthuke/awesome-knowledge-graph). To explain more clearly, we will use the following figure to illustrate the process of building a knowledge graph.

<div align="center">
    <img src="/images/LLM_KG/KG_building_process.svg" alt="Image 2" height=300>
    <figcaption align="center">The process of building a knowledge graph is relatively complex and involves multiple stages from data cleaning and pre-processing, to entity and relationship extraction, to knowledge fusion and storage. Building a knowledge graph requires a significant amount of human and material resources, but it greatly improves efficiency and accuracy in knowledge management and data integration.
</figcaption>
</div>

As shown in the picture, building a knowledge graph is an intricate process that primarily consists of six stages: Knowledge Collection, Knowledge Integration, Knowledge Storage, Knowledge Computation, and Knowledge Application. It begins with gathering the data, extracting relevant entities and relationships from this data, then integrating the data into a coherent, unified format. This structured data is then stored using appropriate methods for easy retrieval and computational processes. The knowledge graph is finally put into action in applications such as semantic search and question answering. Each of these stages plays a crucial role in the construction of a functional and efficient knowledge graph.

Knowledge Collection is the first step in the process of creating a knowledge graph. This involves a procedure known as Automatic Crawl, a method used for collecting data from various sources like web pages, documents, and databases. The collected data is then processed to extract relevant entities and their relations in a process called Entity Extraction and Relation Extraction. Entities refer to distinct objects, concepts, or individuals like a person, place, event, or an organization, while relations define how these entities interact or are related to each other.

The next phase is Knowledge Integration, which encompasses Entity Linking, Entity Disambiguation, and Entity Alignment. Entity Linking connects entities from the collected data to their corresponding entities in the knowledge graph. Entity Disambiguation, on the other hand, deals with identifying and distinguishing entities with similar or identical names. Entity Alignment is crucial when integrating knowledge from different sources or languages, as it identifies the same real-world entity across different data sources or languages.

Knowledge Storage is the stage where the integrated knowledge is stored for efficient use. This includes ER (Entity-Relationship) Storage, where entities and their relations are stored in a structured manner. Graph Storage involves storing the knowledge graph in a graph database, a storage system optimized for storing and querying graph data. Graph Retrieval and Formal Query are techniques to efficiently fetch the stored data for further processing or answering user queries.

The Knowledge Computation phase involves creating a meaningful representation of the knowledge graph and performing inference tasks. Knowledge Representation involves structuring the knowledge graph in a way that both humans and computers can understand. Knowledge Inference is the process of deducing new knowledge from the existing knowledge graph. Graph Complement is an operation that fills in missing information in the graph by inferring from the available data.

Finally, the Knowledge Application stage puts the knowledge graph into action. Semantic Search uses the knowledge graph to provide more accurate and context-aware search results. Knowledge Question Answering (QA) leverages the knowledge graph to answer queries by understanding the context, entities, and their relations involved in the query. This stage effectively demonstrates the value of a knowledge graph in improving information retrieval and understanding.

In summary, building a knowledge graph is a complex process that involves various stages, each with its specific role and importance. The result is a powerful tool that enhances our ability to search, understand, and infer knowledge.

## Language Model

In contrast to knowledge graphs, large language models (LLMs) utilize neural networks to model knowledge. One of the most renowned LLMs is the GPT series, which is a transformer-based language model. I illustrates the training process of the GPT series.

The GPT series has reached several milestones, with GPT-3, InstructGPT, and ChatGPT being among the most significant. With a large corpus and unsupervised learning, GPT-3 is capable of generating human-like text. To enhance GPT's ability to adhere to instructions, InstructGPT was developed, which employs supervised learning with human-labelled context following the instructions, and uses RLHF to generate text that is more favorable. ChatGPT, on the other hand, was designed to improve GPT's ability to converse with humans. ChatGPT employs a similar approach to InstructGPT, but is intended to produce text that is more like human conversation.

<div align="center">
    <img src="/images/LLM_KG/gpt_process.svg" alt="gpt_process" width=2000>
    <figcaption align="center"> training process of GPT series.</figcaption>
</div>

While the GPT series has achieved considerable success in numerous NLP tasks, it still experiences several issues that can prove challenging to address. Some of these problems can be attributed to the training methods utilized by the model.

For instance, while the utilization of a large corpus has benefitted the GPT series, it has also resulted in the acquisition of biases contained in the corpus, leading to the model experiencing low consistency and a higher likelihood of producing fake-looking contexts that may appear correct.

In addition, the supervised learning approach used by InstructGPT and ChatGPT is not immune to bias, as the diverse backgrounds of the labelers may impact the model's general behavior, making it hard to detect and mitigate. A well-known example of such an occurrence is observed in the case of Behavior Cloning. For simplicity, I will use a simple example to illustrate this phenomenon.

<div align="center">
    <img src="/images/LLM_KG/BC_example.svg" alt="BC_example" height=300>
    <figcaption align="center">Behavior Cloning</figcaption>
</div>

Assuming that the LLM can only accept very limited tokens. In this case, although labeler provide a conclusion and corresponding evidence. However, with a limited number of tokens, the LLM can only 'saw' a strong conclusion with no evidence. To clone the behavior of the labeler, the LLM will start to fabricate evidence to support a conclusion. This is a simple example, but it demonstrates how the LLM can be biased by the labeler. For more details, please refer to [Behavior Cloning](https://www.alignmentforum.org/posts/BgoKdAzogxmgkuuAt/behavior-cloning-is-miscalibrated).

# combination of LLMs and KGs

## How can KGs help LLMs?

It is evident that *high-quality* knowledge graphs (KGs) can assist LLMs in achieving better accuracy, consistency, and explainability. However, how can this idea be implemented? In this section, we will discuss two methods: KGs as training data and KGs as part of the prompt.



### KGs as training data

One straightforward approach is to utilize KGs as training data. However, as a language model, the GPT series can only accept text as input, necessitating the conversion of KGs to text format. One prespective work is [TekGen](https://arxiv.org/abs/2010.12688) proposed by Google. The underlying workings of TekGen are depicted in the figure below.

<div align="center">
    <img src="/images/LLM_KG/graph_to_text.png" alt="graph_to_text" height=300>
    <figcaption align="center">Pipelines for training the TEKGEN model and generating the KELM corpus. In Step I , KG triples are aligned with Wikipedia text using distant supervision. In Steps 2&3, T 5 is fine-tuned sequentially first on this corpus, followed by a small number of steps on the WebNLG corpus, In Step 4, BERT is fine-tuned to generate a semantic quality score for generated sentences w.r.t. triples. Steps 2, 3 & 4 together form TEKGEN. To generate the KELM corpus, in Step 5, entity subgraphs are created using the relation pair alignment counts from the training corpus generated in step I . The subgraph triples are then converted into natural text using TEKGEN.</figcaption>
</div>

With the help of TekGen, we can convert KGs to text and use them as training data no matter at pre-training stage or fine-tuning stage. However I don't think this methodology is the best way to leverage KGs. The reasons are two-fold. First, the scale of KGs is limited. Although Knowledge graphs are high-quality knowledge source. The scale is limited to change the distribution of the training dataset. So the effect of this method is limited. Second, this methodology makes the explainability of KGs into black box. KGs are structured data with high explainability. But after converting to text, we send the explainability of KGs into black box.

### KGs as part of the prompt


Another method is to use KGs as part of prompt. In another word, we can use KGs as a tool of LLMs to generate text by feeding topic-related KGs as part of the prompt. The overall working principle of this method is depicted in the figure below.

<div>
    <img src="/images/LLM_KG/chat_based_on_KG.svg" alt="chat_based_on_KG" height=300>
    <figcaption align="center"></figcaption>
</div>

This methodology become popular as [Toolformer](https://arxiv.org/abs/2302.04761) published. The main idea of Toolformer is to tuning LLMs have the ability to generate API queries. Different tools can be leverage to implement different functions following the queries and return the results to LLMs. Inspired by this idea, [Graph Toolformer](https://github.com/jwzhanggy/Graph_Toolformer/tree/main/%E4%B8%AD%E6%96%87%E4%BB%8B%E7%BB%8D) implemented rich API templates to help LLMs handle graph-related tasks.

<div align="center">
    <img src="/images/LLM_KG/toolformer_graph_toolformer.png" alt="Image 9" height=300>
    <figcaption align="center">Toolformer and Graph Toolformer</figcaption>
</div>

The Toolformer framework need tuning LLMs to know how to generate API queries which is hard to be implemented for most of us. We can also make it easier by asking LLMs writing SQL to interact with graph database directly. For example, [This project](https://medium.com/neo4j/context-aware-knowledge-graph-chatbot-with-gpt-4-and-neo4j-d3a99e8ae21e) leverage GPT-4 to generate Cypher queries to interact with a Neo4j database which contains knowledge about movies. With few efferot, we can make a chatbot which can answer questions about movies.

## How can LLMs help KGs?

Although high-quality knowledge graphs can help LLMs. The high-quality knowledge graphs are hard to build. So, reverse thinking, can LLMs help KGs to build high-quality knowledge graphs? The answer is yes. In this section, we will discuss two methods: *LLMs act as a knowledge graph* and *LLMs as a tool to build knowledge graph*. This mean idea is depicted in the figure below. 

<div align="center">
    <img src="/images/LLM_KG/LLM_to_KG_illustration.svg" alt="LLM_to_KG_illustration" height=200>
    <figcaption align="center">LLM_gen_KG_illustration</figcaption>
</div>

The most straightforward way to leverage LLMs to build KGs is to let LLMs act as a knowledge graph. However, nowadays, the ability of LLMs is limited (we will discuss this later). To be more practical, we can use LLMs as a tool to build KGs. For example, we can use LLMs as a tool to extract entities and relations from text. We will discuss these two methods in detail in the following.

### LLMs act as a knowledge graph

The first method is to use LLMs as a knowledge graph. As we discussed before, LLMs itself contains a lot of knowledge. So can we use LLMs as a knowledge graph directly? To be more specific, in the last section, we use KGs as part of the prompt to help LLMs generate text. In that case, we use the knowledge in KGs to enhance the ability of LLMs. However, if the ability of LLMs is strong enough, we can use LLMs as a knowledge graph directly. The overall working principle of this method is depicted in the figure below.

<div align="center">
    <img src="/images/LLM_KG/LLM_as_KG_illustration.svg" alt="LLM_as_KG_illustration" height=300>
    <figcaption align="center">LLM_as_KG_illustration</figcaption>
</div>

[This paper](https://arxiv.org/pdf/2204.06031.pdf) has make a comprehensive discussion what abilities LLMs should have to act as a knowledge graph which is summarized in the following figure.

<div align="center">
    <img src="/images/LLM_KG/LLM_as_KG.png" alt="LLM_as_KG" height=600>
    <figcaption align="center">The abilities LLMs should have to act as a knowledge graph.</figcaption>
</div>

Take Consistency as an example. To act as a knowledge graph, LLMs should have the ability to answer questions about the same topic consistently. 
The consistency体现在多个方面:
1. Paraphrase: sentences that convey approximately the same meaning using different words. LLM-as-KG should provide same results when queried for the same fact but under a different wording.
2. Common sense: Previous work explores the brittleness of LMs and the addition of a negation element (e.g. not) to a probe. Specifically, a LM can maintain two contradictory beliefs in its parameters, such as “Birds can fly” and “Birds cannot fly”, showing that they are insensitive to the contextual impacts of negation.
3. Multilingual: LLM-as-KG should provide same results when queried for the same fact but under a different language.

If you are interested in this topic, you can read this paper for more details. It is not hard to find out that nowadays LLMs still have a long way to go to act as a knowledge graph. But it is still a promising direction.

### LLMs as a tool to build knowledge graph

The other method is to use LLMs as a tool to build knowledge graph. This method is more practical and has been implemented by many projects.

For example, [Knowledge-graph-from-GPT-3](https://github.com/tomhartke/knowledge-graph-from-GPT-3) used GPT-3 to generate triples from QA pairs. Then, leverage graph embedding to infer the triples and build a knowledge graph. The function of GPT-3 in this project is depicted in the figure below. As we can see, GPT-3 is only used at the entity extraction stage. 

<div align="center">
    <img src="/images/LLM_KG/GPT3_KG.png" alt="Image 5" height=400>
    <figcaption align="center">The function of GPT-3 in [Knowledge-graph-from-GPT-3](https://github.com/tomhartke/knowledge-graph-from-GPT-3)</figcaption>
</div>

After chatGPT proposed, LLM can be more powerful for entity and relation extraction with [prompt engineering](https://lilianweng.github.io/posts/2023-03-15-prompt-engineering/). A [Zero-shot method](https://arxiv.org/abs/2302.10205) claim that Chat-format prompt are more effective than vanilla prompt for Information Extraction. The famous package, [Langchain](langchain.com), also implement related functions to extract triples from plain text. I'm really amazed by the power of Prompt Engineering when I use LangChain and I recommend you to try this package to unlock the power of LLMs. Based on LangChain, [Kor](https://github.com/eyurtsev/kor) implement a pipeline to extract entities and relations from plain text. All we need to do is to provide concrete descriptions of entities and relations.

<div align="center">
    <img src="/images/LLM_KG/LLM_gen_KG_from_text.svg" alt="Image 5" height=300>
    <figcaption align="center">The overall working principle of this project.</figcaption>
</div>

With the workflow above, we can extract triples from plain text and create and modify a knowledge graph. There are brief implementations which we can paly with online. [GraphGPT](https://graphgpt.vercel.app/) is a demo which can extract triples from plain text. After providing your OpenAI API key, you can play with it. The following figure shows the result of extracting triples from a sentence.