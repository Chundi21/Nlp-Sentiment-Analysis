 Nlp-Sentiment-Analysis
 Amazon Review Sentiment Analysis

 Overview
Sentiment analysis pipeline built on the Amazon Polarity dataset, a collection of 
Amazon customer reviews spanning 18 years with approximately 4 million entries. 
The goal was to classify customer reviews as positive or negative by understanding 
the contextual patterns in the text.

What I Did
- Loaded and explored the Amazon Polarity dataset from Hugging Face Datasets
- Preprocessed and sampled review text data for analysis
- Applied a pre-trained Hugging Face Transformer model (DistilBERT fine-tuned on SST-2)
  to classify customer sentiment
- Carried out the data processing with panadas and regular expressions
- Made use of sklearn for vectorization, logistic regression, and so on
- Tested the accuracy using evaluation metrics namely F1 score,recall and precision
- Analyzed model outputs to identify patterns in positive vs negative customer feedback
- A final visualization 

Key Findings
- The model successfully classified review sentiment by learning contextual language patterns
- Negative reviews tended to contain specific complaint-driven language around the product 
  quality and delivery
- Positive reviews emphasized satisfaction with value and product description accuracy

 Tech Stack
- Python(Pandas,Sklearn,re,matplotlib,seaborn)
- Hugging Face Transformers & Datasets
- Jupyter Notebook

 How to Run
1. Clone the repo
2. Install dependencies: `pip install transformers datasets pandas`
3. Open the notebook and run all cells

 Dataset
Amazon Polarity Dataset — Hugging Face (https://huggingface.co/datasets/fancyzhx/amazon_polarity/viewer)
