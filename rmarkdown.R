# Markdown Lesson
# Vaguely using https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet
# as a guidepost
# Heres an entire guidebook
# https://bookdown.org/yihui/rmarkdown/r-code.html
## Packages needed
install.packages("rmarkdown")

## Lightweight Mark up language for typesetting and more




## Creating a Markdown



## Text level functions
### Headers
### emphasis
### lists
### links

## Code
## In line
## Code chunks
surveys_complete <- surveys %>%
  filter(!is.na(weight),
    !is.na(hindfoot_length),
    !is.na(sex))

species_counts <- surveys_complete %>% 
  count(species_id) %>% 
  filter(n >= 50) 

species_counts

surveys_complete <- surveys_complete %>% 
  filter(species_id %in% species_counts$species_id)

ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1, aes(color = species_id))
## Echo and eval

## Images
## ![]
## knitr::include_graphics("temp.png")
## Width options 
## fig.align = 'center'
## fig.width (r generated only) versus out.width (all/%)
# http://www.zevross.com/blog/2017/06/19/tips-and-tricks-for-working-with-images-and-figures-in-r-markdown-documents/#arguments-out.width-and-out.height-apply-to-both-existing-images-and-r-generated-figures

## HTML website creation
