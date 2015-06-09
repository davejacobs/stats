# Stats #

## Description ##

This is a prototype of a statistical library for Ruby. Starting out, the purpose of the library is to be readable (for people studying statistics), to be well-tested (against R and Python statistical functions), and to be useful for Small Data. Big Data can come later, if I have enough fun. With `stats`, I aim to create an API that makes statistics intuitive and harder to mess up. For example, I'd like to take a stab at an assumption framework that can tag specific functions with assumptions that will throw warnings if they're not met.

---

## Try it out ##

Once this is stable and fully tested (it is so far for all the functions listed below), I'll consider publishing it as a gem. Until then, you can play around with `master`:

    brew install gsl
    git clone https://github.com/davejacobs/stats.git
    cd stats
    bundle

## To implement ##

### For developers ###

- [x] Get Ruby GSL bindings (`gem install gsl`) to work on Ruby 2.0/OS X
- [ ] Implement gemspec so this is installable via git URL

### Distribution functions ###

- [x] Normal distribution - PDF &amp; CDF
- [x] Chi square distribution - PDF &amp; CDF
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
- [x] Wilcoxon rank sum test
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
- [ ] Test using R integration and something like [Rantly](https://github.com/hayeah/rantly)

Resources
---------

- [How to choose the right statistical test](http://www.graphpad.com/www/book/choose.html)
- [Wilkinson's *Statistics Quiz* (RTF)](http://tspintl-test.com/products/tsp/benchmarks/wilk.rtf)
- Assessing the reliability of statistical software
  - [Part 1](http://www.questia.com/googleScholar.qst?docId=5001390400)
  - [Part 2](http://www.questia.com/googleScholar.qst?docId=5001888610)
