library(tidyverse)

download.file("https://ndownloader.figshare.com/files/11930600?private_link=fe0cd1848e06456e6f38",
              "data/surveys_complete2.csv")

surveys_complete <-read_csv("data/surveys_complete2.csv")
View(surveys_complete)

# GGPLOT2
#Basic ggplot2 template:
#  ggplot(data = , mapping=aes()) + geom_XXX()

ggplot(data=surveys_complete, aes(x=weight, y=hindfoot_length)) + 
  geom_point()

ggplot(data=surveys_complete, aes(x=weight, y=hindfoot_length)) + 
  geom_point(alpha=0.1)

ggplot(data=surveys_complete, aes(x=weight, y=hindfoot_length)) + 
  geom_point(alpha=0.1, aes(color=species_id))
#or
ggplot(data=surveys_complete, aes(x=weight, y=hindfoot_length, color=species_id)) + 
  geom_point(alpha=0.1)

#Challenge 
#Use what you just learned to create a scatter plot of 
#weight (y-axis) over species_id (x-axis) with 
#the plot types showing in different colors. 
#Is this a good way to show this type of data? 

ggplot(data=surveys_complete, aes(x=species_id, y=weight)) + 
  geom_point(alpha=0.1, aes(color=factor(year)))

ggplot(data=surveys_complete, aes(x=species_id, y=weight)) + 
  geom_point(alpha=0.1, aes(color=species_id))

ggplot(data=surveys_complete, aes(x=species_id, y=weight)) + 
  geom_boxplot(alpha=0.1, aes(color=species_id))

ggplot(data=surveys_complete, aes(x=species_id, y=weight)) + 
  geom_jitter(alpha=0.1, color="tomato") +
  geom_boxplot()


surveys_complete$plot_id <-factor(surveys_complete$plot_id)
ggplot(data=surveys_complete, aes(x=species_id, y=weight)) + 
  geom_jitter(alpha=0.1, aes(color=plot_id)) +
  geom_boxplot()
#or
ggplot(data=surveys_complete, aes(x=species_id, y=weight)) + 
  geom_jitter(alpha=0.1, aes(color=factor(plot_id))) +
  geom_boxplot()


#Challenges
#Boxplots are useful summaries, but hide the shape of the distribution. 
#For example, if the distribution is bimodal, we would not see it in a boxplot. 
#An alternative to the boxplot is the violin plot, 
#where the shape (of the density of points) is drawn.
#Replace the box plot with a violin plot; see geom_violin().
ggplot(data=surveys_complete, aes(x=species_id, y=weight)) + 
  geom_jitter(alpha=0.1, aes(color=factor(plot_id))) +
  geom_violin()

#In many types of data, it is important to consider the scale of the observations. 
#For example, it may be worth changing the scale of the axis to better 
#distribute the observations in the space of the plot. 
#Changing the scale of the axes is done similarly to
#adding/modifying other components (i.e., by incrementally adding commands). 
#Try making these modifications:
# Represent weight on the log10 scale; see scale_y_log10().

ggplot(data=surveys_complete, aes(x=species_id, y=weight)) + 
  geom_violin()+ scale_y_log10()


#So far, we’ve looked at the distribution of weight within species. 
#Try making a new plot to explore the distribution of another 
#variable within each species.

#Create a boxplot for hindfoot_length. 
#Overlay the boxplot layer on a jitter layer to show actual measurements.

#Add color to the data points on your boxplot according to the 
#plot from which the sample was taken (plot_id).

#Hint: Check the class for plot_id. 
#Consider changing the class of plot_id from integer to factor. 
#Why does this change how R makes the graph?

ggplot(data=surveys_complete, aes(x=species_id, y=hindfoot_length)) + 
  geom_jitter(alpha=0.1, aes(color=factor(plot_id))) +
  geom_boxplot()


##

yearly_count <-surveys_complete %>%
  group_by(year, species_id) %>%
  tally()
View(yearly_count)
ggplot(data = yearly_count, aes(x=year,y=n)) + 
  geom_line()
  
ggplot(data = yearly_count, aes(x=year,y=n, group=species_id)) + 
  geom_line()
ggplot(data = yearly_count, aes(x=year,y=n, color=species_id)) + 
  geom_line()

ggplot(data = yearly_count, aes(x=year,y=n)) + 
  geom_line() + 
  facet_wrap(~ species_id)

yearly_sex_count <-surveys_complete %>%
  group_by(year, species_id, sex) %>%
  tally()
View(yearly_sex_count)

ggplot(data = yearly_sex_count, aes(x=year,y=n, color=sex)) + 
  geom_line()

ggplot(data = yearly_sex_count, aes(x=year,y=n, color=sex)) + 
  geom_line() + 
  facet_wrap(~ species_id)


ggplot(data = yearly_sex_count, aes(x=year,y=n, color=sex)) + 
  geom_line() + 
  facet_wrap(~ species_id) +
  theme_bw() +
  theme(panel.grid = element_blank())

#n es conteo
ggplot(data = yearly_sex_count, aes(x=year,y=n, color=sex)) + 
  geom_line() + 
  facet_wrap(~ species_id) +
  theme_bw() +
  theme(panel.grid = element_blank(), 
        text= element_text(size=16),
        axis.text.x = element_text(color="grey20",size=12,angle=90)) +
  labs(title= "Obs. species over time", x="Year of observation", 
       y="NUmber of observations")

grey_theme <- theme(panel.grid = element_blank(), 
                    text= element_text(size=16),
                    axis.text.x = element_text(color="grey20",size=12,angle=90))

ggplot(data = yearly_sex_count, aes(x=year,y=n, color=sex)) + 
  geom_line() + 
  facet_wrap(~ species_id) +
  theme_bw() +
  grey_theme +
  labs(title= "Obs. species over time", x="Year of observation", 
       y="NUmber of observations")


#Challenge
#With all of this information in hand, please 
#take another five minutes to either improve one of the plots 
#generated in this exercise or create a beautiful graph of your own. Use the RStudio ggplot2 cheat sheet for inspiration. Here are some ideas:
  
#See if you can change the thickness of the lines.

#Can you find a way to change the name of the legend? What about its labels?

#Try using a different color palette 
#(see http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/).

grey_theme <- theme(panel.grid = element_blank(), 
                    text= element_text(size=16),
                    axis.text.x = element_text(color="grey20",size=12,angle=90),
                    axis.text.y = element_text(color="green",size=18))

ggplot(data = yearly_sex_count, aes(x=year,y=n, color=sex)) + 
  geom_line(linetype = 1, size=2) + 
  facet_wrap(~ species_id) +
  theme_bw() +
  grey_theme +
  labs(title= "Obs. species over time", x="Year of observation", 
       y="NUmber of observations")

## Save!!

ggplot(data = yearly_sex_count, aes(x=year,y=n, color=sex)) + 
  geom_line(linetype = 1, size=2) + 
  facet_wrap(~ species_id) +
  theme_bw() +
  grey_theme +
  labs(title= "Obs. species over time", x="Year of observation", 
       y="NUmber of observations")

my_plot <- ggplot(data = yearly_sex_count, aes(x=year,y=n, color=sex)) + 
  geom_line(linetype = 1, size=2) + 
  facet_wrap(~ species_id) +
  theme_bw() +
  grey_theme +
  labs(title= "Obs. species over time", x="Year of observation", 
       y="NUmber of observations")

ggsave("plots/my_first_plot.png", my_plot, width = 15, height = 10, dpi=300)





