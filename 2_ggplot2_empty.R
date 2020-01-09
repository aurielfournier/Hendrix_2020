### Data Visualization with ggplot2

















## install.packages("hexbin")
## library(hexbin)

## surveys_plot +
##  geom_hex()

## ### Challenge with hexbin
## ##
## ## To use the hexagonal binning with **`ggplot2`**, first install the `hexbin`
## ## package from CRAN:
## 
## install.packages("hexbin")
## library(hexbin)
## 
## ## Then use the `geom_hex()` function:
## 
## surveys_plot +
##     geom_hex()
## 
## ## What are the relative strengths and weaknesses of a hexagonal bin
## ## plot compared to a scatter plot?



















## ## Challenge with boxplots:
## ##  Start with the boxplot we created:
## ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
##   geom_boxplot(alpha = 0) +
##   geom_jitter(alpha = 0.3, color = "tomato")
## 
## ##  1. Replace the box plot with a violin plot; see `geom_violin()`.
## 
## ##  2. Represent weight on the log10 scale; see `scale_y_log10()`.
## 
## ##  3. Create boxplot for `hindfoot_length` overlaid on a jitter layer.
## 
## ##  4. Add color to the data points on your boxplot according to the
## ##  plot from which the sample was taken (`plot_id`).
## ##  *Hint:* Check the class for `plot_id`. Consider changing the class
## ##  of `plot_id` from integer to factor. Why does this change how R
## ##  makes the graph?
## 

























## ### Plotting time series challenge:
## ##
## ##  Use what you just learned to create a plot that depicts how the
## ##  average weight of each species changes through the years.
## 









## install.packages("gridExtra")



# This is a taste of what you can do with `ggplot2`. RStudio provides a
# really useful cheat sheet of the different layers available, and more
# extensive documentation is available on the [ggplot2 website][ggplot-doc].
# Finally, if you have no idea how to change something, a quick google search will
# usually send you to a relevant question and answer on Stack Overflow with reusable
# code to modify!

# http://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf
# http://docs.ggplot2.org/current/
# you can build your own themes (we'll cover this later)
# OR you can use some pre made themes
# https://github.com/jrnold/ggthemes


?theme # shows you all the little things you can manipulate in a ggplot
# thus far I've always been able to get done what needs doing with a custom theme
# look at the graph below, its pretty visually assualting
# figure out how to fix it

ggplot(data=yearly_sex_counts, 
  aes(x = year, 
    y = n, 
    group=sex, color=sex)) +
  geom_line() + 
  facet_wrap(~genus, ncol=2)+
  ylab("Life Expectancy")+
  theme(axis.text.x = element_text(size = 15, ang=90, color = "purple"), 
    axis.text.y = element_text(size = 2, color = "red"), 
    axis.title.y = element_text(size = 20), 
    plot.background = element_rect(fill="green"), 
    panel.background = element_rect(fill="red", color="black"), 
    panel.grid.major = element_line(colour = "red"), 
    panel.grid.minor = element_line(colour = "purple"), 
    title = element_text(size = 1), 
    #        axis.line.x = element_line(colour = "black"), 
    #        axis.line.y = element_line(colour = "black"), 
    strip.background = element_rect(fill = "orange", color = "black"), 
    strip.text = element_text(size = 15, color="red"),
    legend.background = element_rect(fill="black"),
    legend.text = element_text(color="gray"),
    legend.key=element_rect(fill="white"))




######################
# Colors (RColorBrewer)
#####################
#http://colorbrewer2.org/
library(RColorBrewer)
display.brewer.all(n=NULL, type="all", select=NULL, exact.n=TRUE,colorblindFriendly=TRUE)

mypalette<-brewer.pal(4,"Greens")

ggplot(data=abird, 
  aes(x=state, 
    y=samplesize, 
    fill=state)) + 
  geom_boxplot()+ 
  ggtitle("TITLE HERE")+ 
  xlab("text here")+ 
  ylab("text here") + 
  scale_fill_manual(values=mypalette)

mypalette<-brewer.pal(4,"Set2")

mypalette[2] <- "#000000"

ggplot(data=abird, 
  aes(x=state, 
    y=samplesize, 
    fill=state)) + 
  geom_boxplot()+ 
  ggtitle("TITLE HERE")+ 
  xlab("text here")+ 
  ylab("text here") + 
  scale_fill_manual(values=mypalette)

