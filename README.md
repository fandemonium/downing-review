# A binary peer-review quality assessment instrument for self-assessment, review weighting, and referee feedback

## Authors: Clay Williams, Chris Filstrup, Hannah Carroll, Davide Faggionato, Fan Yang, Mindy Morales, Adina Howe, John Downing

This is data and code for evaluating our peer-review quality assessment.

Briefly, we have collected instructions to authors and store them here as "*.txt" files.

Two scripts, preliminary names:

parse.py - identifies key words in our rubric and outputs counts to summary.tsv
parse2.py - identifies all key words (not necessarily in our rubric) and outputs to summary_cum.tsv

To run these scripts, the following needs to be done:
- All text files need to be in the same directory as the parse.py script.
- run:  python parse.py
- output:  summary.tsv

To interact with this data (e.g., plotting), one can plot the analysis in R with analysis.R.

To run this analysis:
- Add metadata information into this directory
- Install dependencies in script
- Execute analysis.R
