---
title: "Rmarkdown introduction"
output:
  html_document:
    toc: true
    toc_depth: 2
    toc_float: true
    number_sections: true
    keep_md: true
---

Note: This introduction was developed largely by Julien Bruns of NCEAS.



# Some Markdown fun

## Adding an image

- Markdown way: 

```
![LTER logo](images/LTER-logo.png)
```
![LTER logo](https://lternet.edu/wp-content/uploads/2018/02/LTER-network-horizontal.png)

**=> not much control!!!**

<br>

- Using HTML tags: 

<br>

<img src="images/LTER-logo.png" width="50%" align="right" alt="LTER logo" />

<br>
<br>

- Using code chunks: 


```r
  knitr::include_graphics("images/LTER-logo.png")
```


<div class="figure" style="text-align: center">
<img src="./images/LTER-logo.png" alt="LTER logo" width="50%" />
<p class="caption">LTER logo</p>
</div>

## Adding an URL

Pure markdown: <http://www.lternet.edu>

This will also work: http://www.lternet.edu

Adding link to a word: [LTER](http://www.lternet.edu)

Opening the link in a new window (R Markdown): [LTER](http://www.lternet.edu){target="_blank"}



---

<img src="images/challenge.png" align="left" alt="Question" /> 

### Exercise

<br>

**Task 1**

- Insert the `rmarkdown` hex sticker (http://hexb.in/hexagons/rmarkdown.png) centered in this document and add a legend 
- Add some text describing `R markdown` and list 2-3 things you think you will like about it
- Add a URL to our class Book (R for Data Science)
- **Bonus**: How would you make sure the hex sitcker has a height of 2"? 

**Task 2**

- Go on the giphy website: https://giphy.com/ 
- Choose a GiF you like
- Add it to your document in a way that you can see it animated


_DONE?! High-Five the cat then!_

<div class="figure" style="text-align: center">
<img src="https://media.giphy.com/media/10ZEx0FoCU2XVm/giphy.gif" alt="Checked!!" width="50%" />
<p class="caption">Checked!!</p>
</div>


---

# Code Chunk

## Insert a code chunk

- From GUI
- Using keyboard code chunk: `Ctrl` + `Alt` + `I` (`Cmd` + `Option` + `I` on macOS).


```r
library(tidyverse)
```

```
## ── Attaching packages ────────────────────────────────────────────── tidyverse 1.2.1 ──
```

```
## ✔ ggplot2 3.0.0     ✔ purrr   0.2.5
## ✔ tibble  1.4.2     ✔ dplyr   0.7.6
## ✔ tidyr   0.8.1     ✔ stringr 1.3.1
## ✔ readr   1.1.1     ✔ forcats 0.3.0
```

```
## ── Conflicts ───────────────────────────────────────────────── tidyverse_conflicts() ──
## ✖ dplyr::filter() masks stats::filter()
## ✖ dplyr::lag()    masks stats::lag()
```

```r
iris_avg <- iris %>%
  group_by(Species) %>%
  summarise_all(funs(median = median))

iris_avg
```

```
## # A tibble: 3 x 5
##   Species Sepal.Length_me… Sepal.Width_med… Petal.Length_me…
##   <fct>              <dbl>            <dbl>            <dbl>
## 1 setosa               5                3.4             1.5 
## 2 versic…              5.9              2.8             4.35
## 3 virgin…              6.5              3               5.55
## # ... with 1 more variable: Petal.Width_median <dbl>
```


---

<img src="images/challenge.png" align="left" alt="Question" /> 

### Exercise

<br>

**Task**

For our writeups, we will not want the `Tidyverse` message in our final document. What should you try to change to the above code chunk to  do so?

---

## Some basic plotting


```r
ggplot(iris_avg, aes(x=Species, y =Sepal.Length_median)) + geom_bar(stat = "identity")
```

![](rmarkdown-intro_files/figure-html/iris median plot-1.png)<!-- -->

---

<img src="images/challenge.png" align="left" alt="Question" /> 

### Exercise

<br>

- How could you hide the code and just show the plot?
- Add a legend to your plot
- Make the figure 8" wide

---



# Tables


## Markdown

|   x |   y |   z |
|-----|-----|-----|
|   1 |   2 |   3 |
|   4 |   5 |   6 |

**=> Tedious!!**


## You can render tables of data frames in R Markdown


```r
knitr::kable(iris_avg, caption = "Iris Median data")
```



Table: Iris Median data

Species       Sepal.Length_median   Sepal.Width_median   Petal.Length_median   Petal.Width_median
-----------  --------------------  -------------------  --------------------  -------------------
setosa                        5.0                  3.4                  1.50                  0.2
versicolor                    5.9                  2.8                  4.35                  1.3
virginica                     6.5                  3.0                  5.55                  2.0

But not that convenient if the table is large:


```r
knitr::kable(iris, caption = "Iris data")
```



Table: Iris data

 Sepal.Length   Sepal.Width   Petal.Length   Petal.Width  Species    
-------------  ------------  -------------  ------------  -----------
          5.1           3.5            1.4           0.2  setosa     
          4.9           3.0            1.4           0.2  setosa     
          4.7           3.2            1.3           0.2  setosa     
          4.6           3.1            1.5           0.2  setosa     
          5.0           3.6            1.4           0.2  setosa     
          5.4           3.9            1.7           0.4  setosa     
          4.6           3.4            1.4           0.3  setosa     
          5.0           3.4            1.5           0.2  setosa     
          4.4           2.9            1.4           0.2  setosa     
          4.9           3.1            1.5           0.1  setosa     
          5.4           3.7            1.5           0.2  setosa     
          4.8           3.4            1.6           0.2  setosa     
          4.8           3.0            1.4           0.1  setosa     
          4.3           3.0            1.1           0.1  setosa     
          5.8           4.0            1.2           0.2  setosa     
          5.7           4.4            1.5           0.4  setosa     
          5.4           3.9            1.3           0.4  setosa     
          5.1           3.5            1.4           0.3  setosa     
          5.7           3.8            1.7           0.3  setosa     
          5.1           3.8            1.5           0.3  setosa     
          5.4           3.4            1.7           0.2  setosa     
          5.1           3.7            1.5           0.4  setosa     
          4.6           3.6            1.0           0.2  setosa     
          5.1           3.3            1.7           0.5  setosa     
          4.8           3.4            1.9           0.2  setosa     
          5.0           3.0            1.6           0.2  setosa     
          5.0           3.4            1.6           0.4  setosa     
          5.2           3.5            1.5           0.2  setosa     
          5.2           3.4            1.4           0.2  setosa     
          4.7           3.2            1.6           0.2  setosa     
          4.8           3.1            1.6           0.2  setosa     
          5.4           3.4            1.5           0.4  setosa     
          5.2           4.1            1.5           0.1  setosa     
          5.5           4.2            1.4           0.2  setosa     
          4.9           3.1            1.5           0.2  setosa     
          5.0           3.2            1.2           0.2  setosa     
          5.5           3.5            1.3           0.2  setosa     
          4.9           3.6            1.4           0.1  setosa     
          4.4           3.0            1.3           0.2  setosa     
          5.1           3.4            1.5           0.2  setosa     
          5.0           3.5            1.3           0.3  setosa     
          4.5           2.3            1.3           0.3  setosa     
          4.4           3.2            1.3           0.2  setosa     
          5.0           3.5            1.6           0.6  setosa     
          5.1           3.8            1.9           0.4  setosa     
          4.8           3.0            1.4           0.3  setosa     
          5.1           3.8            1.6           0.2  setosa     
          4.6           3.2            1.4           0.2  setosa     
          5.3           3.7            1.5           0.2  setosa     
          5.0           3.3            1.4           0.2  setosa     
          7.0           3.2            4.7           1.4  versicolor 
          6.4           3.2            4.5           1.5  versicolor 
          6.9           3.1            4.9           1.5  versicolor 
          5.5           2.3            4.0           1.3  versicolor 
          6.5           2.8            4.6           1.5  versicolor 
          5.7           2.8            4.5           1.3  versicolor 
          6.3           3.3            4.7           1.6  versicolor 
          4.9           2.4            3.3           1.0  versicolor 
          6.6           2.9            4.6           1.3  versicolor 
          5.2           2.7            3.9           1.4  versicolor 
          5.0           2.0            3.5           1.0  versicolor 
          5.9           3.0            4.2           1.5  versicolor 
          6.0           2.2            4.0           1.0  versicolor 
          6.1           2.9            4.7           1.4  versicolor 
          5.6           2.9            3.6           1.3  versicolor 
          6.7           3.1            4.4           1.4  versicolor 
          5.6           3.0            4.5           1.5  versicolor 
          5.8           2.7            4.1           1.0  versicolor 
          6.2           2.2            4.5           1.5  versicolor 
          5.6           2.5            3.9           1.1  versicolor 
          5.9           3.2            4.8           1.8  versicolor 
          6.1           2.8            4.0           1.3  versicolor 
          6.3           2.5            4.9           1.5  versicolor 
          6.1           2.8            4.7           1.2  versicolor 
          6.4           2.9            4.3           1.3  versicolor 
          6.6           3.0            4.4           1.4  versicolor 
          6.8           2.8            4.8           1.4  versicolor 
          6.7           3.0            5.0           1.7  versicolor 
          6.0           2.9            4.5           1.5  versicolor 
          5.7           2.6            3.5           1.0  versicolor 
          5.5           2.4            3.8           1.1  versicolor 
          5.5           2.4            3.7           1.0  versicolor 
          5.8           2.7            3.9           1.2  versicolor 
          6.0           2.7            5.1           1.6  versicolor 
          5.4           3.0            4.5           1.5  versicolor 
          6.0           3.4            4.5           1.6  versicolor 
          6.7           3.1            4.7           1.5  versicolor 
          6.3           2.3            4.4           1.3  versicolor 
          5.6           3.0            4.1           1.3  versicolor 
          5.5           2.5            4.0           1.3  versicolor 
          5.5           2.6            4.4           1.2  versicolor 
          6.1           3.0            4.6           1.4  versicolor 
          5.8           2.6            4.0           1.2  versicolor 
          5.0           2.3            3.3           1.0  versicolor 
          5.6           2.7            4.2           1.3  versicolor 
          5.7           3.0            4.2           1.2  versicolor 
          5.7           2.9            4.2           1.3  versicolor 
          6.2           2.9            4.3           1.3  versicolor 
          5.1           2.5            3.0           1.1  versicolor 
          5.7           2.8            4.1           1.3  versicolor 
          6.3           3.3            6.0           2.5  virginica  
          5.8           2.7            5.1           1.9  virginica  
          7.1           3.0            5.9           2.1  virginica  
          6.3           2.9            5.6           1.8  virginica  
          6.5           3.0            5.8           2.2  virginica  
          7.6           3.0            6.6           2.1  virginica  
          4.9           2.5            4.5           1.7  virginica  
          7.3           2.9            6.3           1.8  virginica  
          6.7           2.5            5.8           1.8  virginica  
          7.2           3.6            6.1           2.5  virginica  
          6.5           3.2            5.1           2.0  virginica  
          6.4           2.7            5.3           1.9  virginica  
          6.8           3.0            5.5           2.1  virginica  
          5.7           2.5            5.0           2.0  virginica  
          5.8           2.8            5.1           2.4  virginica  
          6.4           3.2            5.3           2.3  virginica  
          6.5           3.0            5.5           1.8  virginica  
          7.7           3.8            6.7           2.2  virginica  
          7.7           2.6            6.9           2.3  virginica  
          6.0           2.2            5.0           1.5  virginica  
          6.9           3.2            5.7           2.3  virginica  
          5.6           2.8            4.9           2.0  virginica  
          7.7           2.8            6.7           2.0  virginica  
          6.3           2.7            4.9           1.8  virginica  
          6.7           3.3            5.7           2.1  virginica  
          7.2           3.2            6.0           1.8  virginica  
          6.2           2.8            4.8           1.8  virginica  
          6.1           3.0            4.9           1.8  virginica  
          6.4           2.8            5.6           2.1  virginica  
          7.2           3.0            5.8           1.6  virginica  
          7.4           2.8            6.1           1.9  virginica  
          7.9           3.8            6.4           2.0  virginica  
          6.4           2.8            5.6           2.2  virginica  
          6.3           2.8            5.1           1.5  virginica  
          6.1           2.6            5.6           1.4  virginica  
          7.7           3.0            6.1           2.3  virginica  
          6.3           3.4            5.6           2.4  virginica  
          6.4           3.1            5.5           1.8  virginica  
          6.0           3.0            4.8           1.8  virginica  
          6.9           3.1            5.4           2.1  virginica  
          6.7           3.1            5.6           2.4  virginica  
          6.9           3.1            5.1           2.3  virginica  
          5.8           2.7            5.1           1.9  virginica  
          6.8           3.2            5.9           2.3  virginica  
          6.7           3.3            5.7           2.5  virginica  
          6.7           3.0            5.2           2.3  virginica  
          6.3           2.5            5.0           1.9  virginica  
          6.5           3.0            5.2           2.0  virginica  
          6.2           3.4            5.4           2.3  virginica  
          5.9           3.0            5.1           1.8  virginica  


# Embedding interactive elements - HTML widgets

You can use html widgets to add some interactivity to your R markdown documents


## Interactive table

To let the user be able to explore the data, we can create an interactive table


```r
library(DT)
DT::datatable(iris)
```

<!--html_preserve--><div id="htmlwidget-661f3608403914d9df2b" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-661f3608403914d9df2b">{"x":{"filter":"none","data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128","129","130","131","132","133","134","135","136","137","138","139","140","141","142","143","144","145","146","147","148","149","150"],[5.1,4.9,4.7,4.6,5,5.4,4.6,5,4.4,4.9,5.4,4.8,4.8,4.3,5.8,5.7,5.4,5.1,5.7,5.1,5.4,5.1,4.6,5.1,4.8,5,5,5.2,5.2,4.7,4.8,5.4,5.2,5.5,4.9,5,5.5,4.9,4.4,5.1,5,4.5,4.4,5,5.1,4.8,5.1,4.6,5.3,5,7,6.4,6.9,5.5,6.5,5.7,6.3,4.9,6.6,5.2,5,5.9,6,6.1,5.6,6.7,5.6,5.8,6.2,5.6,5.9,6.1,6.3,6.1,6.4,6.6,6.8,6.7,6,5.7,5.5,5.5,5.8,6,5.4,6,6.7,6.3,5.6,5.5,5.5,6.1,5.8,5,5.6,5.7,5.7,6.2,5.1,5.7,6.3,5.8,7.1,6.3,6.5,7.6,4.9,7.3,6.7,7.2,6.5,6.4,6.8,5.7,5.8,6.4,6.5,7.7,7.7,6,6.9,5.6,7.7,6.3,6.7,7.2,6.2,6.1,6.4,7.2,7.4,7.9,6.4,6.3,6.1,7.7,6.3,6.4,6,6.9,6.7,6.9,5.8,6.8,6.7,6.7,6.3,6.5,6.2,5.9],[3.5,3,3.2,3.1,3.6,3.9,3.4,3.4,2.9,3.1,3.7,3.4,3,3,4,4.4,3.9,3.5,3.8,3.8,3.4,3.7,3.6,3.3,3.4,3,3.4,3.5,3.4,3.2,3.1,3.4,4.1,4.2,3.1,3.2,3.5,3.6,3,3.4,3.5,2.3,3.2,3.5,3.8,3,3.8,3.2,3.7,3.3,3.2,3.2,3.1,2.3,2.8,2.8,3.3,2.4,2.9,2.7,2,3,2.2,2.9,2.9,3.1,3,2.7,2.2,2.5,3.2,2.8,2.5,2.8,2.9,3,2.8,3,2.9,2.6,2.4,2.4,2.7,2.7,3,3.4,3.1,2.3,3,2.5,2.6,3,2.6,2.3,2.7,3,2.9,2.9,2.5,2.8,3.3,2.7,3,2.9,3,3,2.5,2.9,2.5,3.6,3.2,2.7,3,2.5,2.8,3.2,3,3.8,2.6,2.2,3.2,2.8,2.8,2.7,3.3,3.2,2.8,3,2.8,3,2.8,3.8,2.8,2.8,2.6,3,3.4,3.1,3,3.1,3.1,3.1,2.7,3.2,3.3,3,2.5,3,3.4,3],[1.4,1.4,1.3,1.5,1.4,1.7,1.4,1.5,1.4,1.5,1.5,1.6,1.4,1.1,1.2,1.5,1.3,1.4,1.7,1.5,1.7,1.5,1,1.7,1.9,1.6,1.6,1.5,1.4,1.6,1.6,1.5,1.5,1.4,1.5,1.2,1.3,1.4,1.3,1.5,1.3,1.3,1.3,1.6,1.9,1.4,1.6,1.4,1.5,1.4,4.7,4.5,4.9,4,4.6,4.5,4.7,3.3,4.6,3.9,3.5,4.2,4,4.7,3.6,4.4,4.5,4.1,4.5,3.9,4.8,4,4.9,4.7,4.3,4.4,4.8,5,4.5,3.5,3.8,3.7,3.9,5.1,4.5,4.5,4.7,4.4,4.1,4,4.4,4.6,4,3.3,4.2,4.2,4.2,4.3,3,4.1,6,5.1,5.9,5.6,5.8,6.6,4.5,6.3,5.8,6.1,5.1,5.3,5.5,5,5.1,5.3,5.5,6.7,6.9,5,5.7,4.9,6.7,4.9,5.7,6,4.8,4.9,5.6,5.8,6.1,6.4,5.6,5.1,5.6,6.1,5.6,5.5,4.8,5.4,5.6,5.1,5.1,5.9,5.7,5.2,5,5.2,5.4,5.1],[0.2,0.2,0.2,0.2,0.2,0.4,0.3,0.2,0.2,0.1,0.2,0.2,0.1,0.1,0.2,0.4,0.4,0.3,0.3,0.3,0.2,0.4,0.2,0.5,0.2,0.2,0.4,0.2,0.2,0.2,0.2,0.4,0.1,0.2,0.2,0.2,0.2,0.1,0.2,0.2,0.3,0.3,0.2,0.6,0.4,0.3,0.2,0.2,0.2,0.2,1.4,1.5,1.5,1.3,1.5,1.3,1.6,1,1.3,1.4,1,1.5,1,1.4,1.3,1.4,1.5,1,1.5,1.1,1.8,1.3,1.5,1.2,1.3,1.4,1.4,1.7,1.5,1,1.1,1,1.2,1.6,1.5,1.6,1.5,1.3,1.3,1.3,1.2,1.4,1.2,1,1.3,1.2,1.3,1.3,1.1,1.3,2.5,1.9,2.1,1.8,2.2,2.1,1.7,1.8,1.8,2.5,2,1.9,2.1,2,2.4,2.3,1.8,2.2,2.3,1.5,2.3,2,2,1.8,2.1,1.8,1.8,1.8,2.1,1.6,1.9,2,2.2,1.5,1.4,2.3,2.4,1.8,1.8,2.1,2.4,2.3,1.9,2.3,2.5,2.3,1.9,2,2.3,1.8],["setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>Sepal.Length<\/th>\n      <th>Sepal.Width<\/th>\n      <th>Petal.Length<\/th>\n      <th>Petal.Width<\/th>\n      <th>Species<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"className":"dt-right","targets":[1,2,3,4]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->


## Interactive Maps

We have a csv file with the all the LTER sites. We can read this file and create an interactive maps in few lines of code

- Show the leaflet
- Render => discuss the `read_csv` message
- How to fix this => `message-FALSE`
- Add a caption


```r
library(leaflet)

# Read the LTER sites
lter_sites <- read_csv("./data/LTER_sites.csv")

# Map of the contiguous US LTER sites
leaflet(data=lter_sites) %>% addTiles() %>% setView(-98, 40, zoom = 4) %>% addCircleMarkers(~Longitude, ~Latitude, popup = ~Code)
```

<div class="figure">
<!--html_preserve--><div id="htmlwidget-b2c8d41117298877194a" style="width:672px;height:480px;" class="leaflet html-widget"></div>
<script type="application/json" data-for="htmlwidget-b2c8d41117298877194a">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"calls":[{"method":"addTiles","args":["//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",null,null,{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"attribution":"&copy; <a href=\"http://openstreetmap.org\">OpenStreetMap<\/a> contributors, <a href=\"http://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA<\/a>"}]},{"method":"addCircleMarkers","args":[[44.212,68.633333,39.1,71.29055,64.8585,32.8736,45.401,33.427,35,25.4682,31.427,42.53,43.94,32.6179,42.4,39.093,18.3,-77,-17.4909,39.993,46.0124,40.6967,59.045,-64.7742,42.759,34.4125,34.353,37.283],[-122.256,-149.606667,-76.3,-156.78861,-147.847,-120.28,-93.201,-111.933,-83.5,-80.8533,-81.371,-72.19,-71.751,-106.74,-85.4,-96.575,-65.8,162.52,-149.826,-105.375,-89.672,-70.8833,-148.7,-64.0545,-70.891,-119.842,-106.882,-75.913],10,null,null,{"interactive":true,"className":"","stroke":true,"color":"#03F","weight":5,"opacity":0.5,"fill":true,"fillColor":"#03F","fillOpacity":0.2},null,null,["AND","ARC","BES","BLE","BNZ","CCE","CDR","CAP","CWT","FCE","GCE","HFR","HBR","JRN","KBS","KNZ","LUQ","MCM","MCR","NWT","NTL","NES","NGA","PAL","PIE","SBC","SEV","VCR"],null,null,{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]}],"setView":[[40,-98],4,[]],"limits":{"lat":[-77,71.29055],"lng":[-156.78861,162.52]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->
<p class="caption">LTER sites of the contiguous US</p>
</div>


# Inline code 

**You can use R to compute values within your text documentation**

For example, you could compute the number of LTER sites from the csv files we used. So if this file is updated because 2 new LTER sites are added by NSF, your text will be automatically updated accordingly!

You can add inline code outside the chunks by using single quotation:

```r
There are `r nrow(lter_sites)` US LTER sites!
```

This will render as:  
**There are 28 US LTER sites!**


---

<img src="images/challenge.png" align="left" alt="Question" /> 

### Exercise

<br>

- Write a sentence stating the number of LTER sites, stipulating today's date. Note: Try googling for a function that returns today's date.   
- Write a sentence with the name of the most northern LTER site. Note: How would you identify and extract this site name from the data?  

---


# Global Chunk Options

**As you can set options for code chunks, you can set the same for all the chunks of the R markdown document.**


## Set your figure size for all


```r
knitr::opts_chunk$set(fig.width=12, fig.height=8)
```


## Output folder 

For example, we could want to save all our plots in a specific folder


```r
knitr::opts_chunk$set(fig.path = "./figures/") 
```


## Set your figure type to `PNG`


```r
knitr::opts_chunk$set(dev = "png")
```

## Know your (default) `Knit` options

Want to know your default knit options?


```r
str(knitr::opts_chunk$get())
```

--

# Knit Options via `YAML` metadata header

See this reference for more option

## Adding a table of content


```yaml
---
title: "Rmarkdown intro"
author: "Your name"
output:
  html_document:
    toc: true
    toc_float: true
---
```

---

<img src="images/challenge.png" align="left" alt="Question" /> 

### Exercise

<br>

Using the Cheat sheet (or the Web):

- Limit the depth of the table of content (TOC) to headers of level-2
- Place the TOC on the left of the document "floating"
- **Bonus**: Make TOC showing all the sections all the time

---



## Adding numbering to headers


```yaml
---
title: "Rmarkdown Intro"
author: "BIO 410/510 Class"
output:
  html_document:
    number_sections: true
---
```

## Save the intermediate the Markdown document


```yaml
---
title: "Rmarkdown intro"
author: "BIO 410/510 Class"
output:
  html_document:
    toc: true
    toc_depth: 2
    toc_float: true
    number_sections: true
    keep_md: true
---
```

# Bibliography

Add your bibliographic file path to the YAML header. Here we are using a `bibtex` file, which is a standard format that most of the Reference manager software can export.


```yaml
---
title: "Rmarkdown intro"
output:
  html_document:
    toc: true
    toc_depth: 2
    toc_float: true
    number_sections: true
bibliography: references.bib
---
```

Then you can cite a reference within your markdown text using: `[@citationKey]`

For example in our file ` reference.bib`, we have a reference to the book `R Markdown: The Definitive Guide`

We can add the following citation: 

```
Most of this material and more can be found in [@xie_r_2018]
```

The References will be added at the bottom of the document when knitted. Note that you will have to add `# References` header at the end of your Rmakrdown document.

---

<img src="images/challenge.png" align="left" alt="Question" /> 

### Exercise

<br>

Write a sentence thanking  `R`, `RStudio` and the `rmarkdown` teams for their awsome tools

---
