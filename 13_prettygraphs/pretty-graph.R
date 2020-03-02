################################################################################
### BIO 410/510                                                              ###
### Communicate: Beautifying graphs                                          ### 
################################################################################

## Objective: To gain an overview of ggplot2 tools for beautifying graphs.

## For simplicity let's use the built-in iris dataset
library(tidyverse)
data("iris")

ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color = Species)) + 
  geom_point() 

###########################
## 1) Labels          ####
###########################

# Use labs() to adjust axes labels
# It's a good idea to replace short variable names with more detailed names, and to give units
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color = Species)) + 
  geom_point() + geom_smooth(method = "lm", se = F) +
  labs(x = "Sepal Length (mm)", y = "Sepal width (mm)")

# TASK: Add a title to the graph. Have the title summarize the main finding of the graph
# rather than just describing what the graph contains


###########################
## 2) Annotation       ####
###########################

# It can be useful to label individual observations, and groups.
# A) replace the legend with in-text
irislabels <- iris %>%
  group_by(Species) %>%
  summarize_all(mean)

ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color = Species)) + 
  geom_point() + geom_text(data  = irislabels, aes(x=Sepal.Length, y=Sepal.Width, label = Species)) + 
  theme(legend.position = "none")

# B) add a figure number
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color = Species)) + 
  geom_point() + annotate("text", x=4.2, y=4.4, label = "A")

# TASK: Make the annotated "A" larger

###########################
## 3) Scales           ####
###########################

# Scales control how data values are mapped visually. 

# ggplot2 makes a best-guess of scales for you. If scales were explicit, it would be:
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color = Species)) + 
  geom_point() +
  scale_x_continuous() +
  scale_y_continuous() +
  scale_colour_discrete()


# Times when you might want to override default scales include:
# 1) You want to tweak a parameter, such as change the breaks on axes 
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color = Species)) + 
  geom_point() +
  scale_y_continuous(breaks = seq(2, 5, by = 1))

# TASK: Remove the axis labels altogether. Hint: try ?scale_y_continuous
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color = Species)) + 
  geom_point()

# 2) You want to replace the scale altogether based on your knowledge of the data
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color = Species)) + 
  geom_point() +
  scale_y_log10() + scale_x_log10()

# 3) Color is a frequently customized scale.
# By default ggplot2 picks colors that are evenly spaced around the color wheel.
# You might want to adjust, for example ColorBrewer scales adjust for color blindness
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color = Species)) + 
  geom_point() +
  scale_color_brewer(palette = "Set1")

# TASK: Change the colors to red, orange and blue using scale_color_manual()
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color = Species)) + 
  geom_point()



###########################
## 4) Zooming          ####
###########################

# There are three ways to adjust the plot limits:
# Adjusting what data are plotted
# Setting xlim and ylim in coord_cartesian()
# Setting the limits in each scale


# 1) Adjusting data versus coord_cartesian
# To zoom in it is usually better to use coord_cartesian()
# Compare: 
iris %>%
  filter(Sepal.Length >= 4, Sepal.Length <= 6, Sepal.Width >= 2.5, Sepal.Width <= 4.5) %>%
  ggplot(aes(x=Sepal.Length, y=Sepal.Width, color = Species)) +
  geom_point() + 
  geom_smooth()

ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color = Species)) + 
  geom_point() + 
  coord_cartesian(xlim = c(4, 6), ylim = c(2.5, 4.5)) + 
  geom_smooth()


## QUESTION: What is different about these approaches?

# 2) Setting the limits on each scale
# For example, we might want to plot the different species separately, but have the same scale

setosa <- iris %>%
  filter(Species == "setosa")

versicolor <- iris %>%
  filter(Species == "versicolor")

ggplot(setosa,  aes(x=Sepal.Length, y=Sepal.Width)) +
  geom_point()

ggplot(versicolor,  aes(x=Sepal.Length, y=Sepal.Width)) +
  geom_point()


# We can set scales based on the full, original data
x_scale <- scale_x_continuous(limits = range(iris$Sepal.Length))
y_scale <- scale_y_continuous(limits = range(iris$Sepal.Width))


ggplot(setosa,  aes(x=Sepal.Length, y=Sepal.Width)) +
  geom_point() +
  x_scale +
  y_scale 

ggplot(versicolor,  aes(x=Sepal.Length, y=Sepal.Width)) +
  geom_point() +
  x_scale +
  y_scale 

###########################
## 5) Themes           ####
###########################

# You can customize the non-data aspects of the plot with themes

ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color = Species)) + 
  geom_point() + theme_bw()

# ggplot2 has 8 built in themes
# TASK: re-plot the graph with another built-in theme


# You can also control the individual components of the plot, like text size:

ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color = Species)) + 
  geom_point() + theme(text = element_text(size = 16))


# You can make your own themes and there's also a whole library of themes:
library(ggthemes)

# Not the *most* useful, but fun:
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color = Species)) + 
  geom_point() + ggthemes::theme_fivethirtyeight()

ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color = Species)) + 
  geom_point() + ggthemes::theme_economist()

ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color = Species)) + 
  geom_point() + ggthemes::theme_excel()


