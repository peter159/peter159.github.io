library(dapre)
library(xlsx)
library(dplyr)

#################################################################################
## production <- read.xlsx("./datasrc.xlsx",sheetIndex = 1,encoding = 'gb2312')
production <- fread("./production.csv")
datainfo(production)
head(production)

ggplot_factor_barplot(production,"age",ggtitle = "production by age")

## word cloud
Results <- production$tag
Results <- sapply(Results,function(x) strsplit(x, ",")) %>%
  unlist %>%
  table %>%
  as.data.frame()
colnames(Results) <- c("word","frequency")
Results

ggplot2::ggplot(Results, aes(x=word, y=frequency, fill=word)) +
  geom_bar(width = 0.75,
           stat = "identity",
           colour = "black",
           size = 1) +
  coord_polar(theta = "x") +
  xlab("") + ylab("") +
  ggtitle("Movie Theme Distribution") +
  theme(legend.position = "none",
        plot.title = element_text(hjust = 0.5,size = 10),
        text = element_text(size = 20),
        axis.text.y = element_text(size = 1)) +
  labs(x = NULL, y = NULL)

plotly::ggplotly(ggplot2::ggplot(Results, aes(x=word, y=frequency, fill=word)) +
                   geom_bar(width = 0.75, stat = "identity", colour = "black", size = 1) +
                   xlab("") +
                   ylab("") +
                   ggtitle("Word Frequency") +
                   theme(legend.position = "none") +
                   dllabs(x = NULL, y = NULL) +
                   theme(plot.subtitle = element_text(vjust = 1),
                         plot.caption = element_text(vjust = 1),
                         axis.text.x = element_text(angle = 90)) +
                   theme(panel.background = element_rect(fill = "honeydew1"),
                         plot.backgrond = element_rect(fill = "antiquewhite"))) %>%
  config(displaylogo = F) %>% config(showLink = F)
