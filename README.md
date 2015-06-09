Description
-----------

Ruby needs a solid, beautiful stats library. This is the beginning of a look
at what that might be.  (Note: this on hold for the moment, but with the right
OSS team, it could be fun to start again.)

Try it out
----------

This is not yet available as a gem (because I want to have better coverage of
common statistical methods before that happens). I do plan to add a gemspec
to this repository so that it can be installed using `gem` regardless. Until then,
try out the following:

    git clone https://github.com/davejacobs/stats.git
    cd stats
    brew install gsl
    bundle

To implement
------------

### For developers ###

- [ ] Get Ruby GSL bindings (`gem install gsl`) to work on Ruby 2.0/OS X
- [ ] Implement gemspec so this is installable via git URL

### Distribution functions ###

- [x] Normal distribution - PDF &amp; CDF
- [x] Chi square distribution - PDF
- [x] T distribution - PDF &amp; CDF
- [x] F distribution - PDF &amp; CDF

### Basic functions ###

- [x] Mean, arithmetic
- [x] Mean, geometric
- [x] Median
- [x] Mode
- [x] Variance
- [x] Standard deviation
- [x] Standard error of the mean (for samples only)
- [x] Relative standard error of the mean (for samples only)
- [x] Coefficient of variation

### Significance tests ###

- [x] Chi square, one-sided
- [x] T-test, single sample
- [x] T-test, two-sample
- [x] T-test, repeated measures
- [ ] Wilcoxon rank sum test
- [ ] Wilcoxon signed rank test
- [ ] Median test
- [ ] Kruskall-Wallis H test
- [ ] Friedman test
- [x] ANOVA, one way
- [ ] Factorial ANOVA, two-way
- [ ] Factorial ANOVA, three-way
- [ ] ANOVA, repeated measures
- [ ] MANOVA
- [ ] ANCOVA
- [ ] Welch's ANOVA
- [ ] Fisher's least significant difference

### Regressions ###

- [ ] Linear regression
- [ ] Multiple linear regression
- [ ] Pearson's correlation
- [ ] Spearman correlation

### Support &amp; other ###

- [x] Basic assumption framework
- [ ] Confidence intervals (general idea)
- [ ] Basic data structures
- [ ] Significance methods on data structures

Resources
---------

- [How to choose the right statistical test](http://www.graphpad.com/www/book/choose.html)
- [Wilkinson's *Statistics Quiz* (RTF)](http://tspintl-test.com/products/tsp/benchmarks/wilk.rtf)
- Assessing the reliability of statistical software
  - [Part 1](http://www.questia.com/googleScholar.qst?docId=5001390400)
  - [Part 2](http://www.questia.com/googleScholar.qst?docId=5001888610)
