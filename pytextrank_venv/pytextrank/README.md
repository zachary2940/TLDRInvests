Instructions for use OS-independent

1) Move pytextrank to a virtualenv, cd Scripts && activate (source activate for linux)
2) Install required packages with pip install -r requirements.txt
3) Run python stage1.py <stock_name>

How does pytextrank work?
Main functions are inside pytextrank.py
There are 4 main stages
1) Text is parsed using spacy, ie the symbols are removed and replace with a period, phrases with quotes are noted and sentences are hashed to a value 
   Then within the sentence each word is noted to be a verb, noun, adjective and it is transformed to the root word
   This list with id, raw text, hashed value and transformed words are saved to a json file

2) Graph is built from these transformed words and phrases and ranked using networkx's pagerank https://networkx.github.io/documentation/networkx-1.10/reference/generated/networkx.algorithms.link_analysis.pagerank_alg.pagerank.html
Render_ranks just shows the visual representation
Results with ranked phrases are saved to another json file

3) Matrixify the list of ranked phrases and get the top sentences based on their distance(?) from each other in the word node graph

4) Beautify the sentences and output into easily read md files
