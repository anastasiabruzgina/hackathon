DataFrame <- read.csv("baboon_mating.csv")
DF <- DataFrame[, -c(1,2,3,6,7,8,9,10,12,13,14,15,16,17,18,19,20)]

DF1 <- DF[!(DF$consort == 0),]

DF2 <- DF[!(DF$conceptive == 0),]

DF3 <- DF[!(DF$consort == 1),]

DF3$consort <- 1 #чтобы нанести на график количество несостоявшихся спариваний
#график #1
ggplot(data = DF1, aes(x = female_age, y = consort))+
  geom_point(position=position_jitter(height=0.05), color = "royalblue")+
  geom_point(data = DF2, aes(x = female_age, y = conceptive),
                             position=position_jitter(height=0.05), 
                             color = "red3")+
  geom_point(data = DF3, aes(x = female_age, y = consort),
             position=position_jitter(height=0.05), 
             color = "grey35")
#серый - количество несостоявшихся спариваний. хотя возможномть была
#синие точки - количество состоявшихся спариваний
#красный - случаи зачатий

p1 <- ggplot(data = DF1, aes(x = female_age, y = consort))+
  geom_point(position=position_jitter(height=0.05), color = "royalblue")+
  geom_point(data = DF2, aes(x = female_age, y = conceptive),
             position=position_jitter(height=0.05), 
             color = "red3")
p2 <- ggplot()+
  geom_point(data = DF3, aes(x = female_age, y = consort),
             position=position_jitter(height=0.05), 
             color = "grey35")

#разделенный график на основе предыдущено для лучшей наглядности
library(patchwork)
p1 / p2

#гистограмма с распределением возраста и количества зачатий
ggplot(data = DF1, aes(x = female_age))+
  geom_histogram(col = 'royalblue')

#распределение плотности вероятности
ggplot(DF2, aes(x = female_age))+ 
  geom_density(color = 'black', fill = 'olivedrab', alpha = 0.5)

# сочетаем красивый график с показательным
# что мы имеем? 1) ненормальный график распределения
# 2) все измерения являются равнозначными
ggplot(DF2, aes(x = female_age)) + 
  geom_histogram(aes(y = stat(density)), fill = 'grey', color = 'black', size = 0.1) +
  geom_density(color = 'black', fill = 'steelblue', alpha = 0.5)
#принадлежат ли эти две выборки одному закону распределения?

quantile(DF2$female_age)
summary(DF2$female_age)
