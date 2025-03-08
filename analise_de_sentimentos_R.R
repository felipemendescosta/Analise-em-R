# Instale os pacotes:
install.packages("syuzhet")
install.packages("RColorBrewer")
install.packages("wordcloud")
install.packages("Rtools")
install.packages("tm")

# Carregue os pacotes
library(syuzhet)
library(RColorBrewer)
library(wordcloud)
library(tm)

texto <- scan(file = "https://raw.githubusercontent.com/programminghistorian/jekyll/gh-pages/assets/domCasmurro.txt", fileEncoding = "UTF-8", what = character(), sep = "\n", allowEscapes = T)

texto_palavras <- get_tokens(texto)
head(texto_palavras)

length(texto_palavras)

oracoes_vetor <- get_sentences(texto)
length(oracoes_vetor)

sentimentos_df <- get_nrc_sentiment(texto_palavras, lang="portuguese")
head(sentimentos_df)

summary(sentimentos_df) #Temos os resultados dos semntimentos podemos mostrar agora em um ploty: Gráfico de Barras

barplot(
  colSums(prop.table(sentimentos_df[, 1:8])),
  space = 0.1,
  horiz = FALSE,
  las = 1,
  cex.names = 0.7,
  col = brewer.pal(n = 8, name = "Set3"),
  main = "'Dom Casmurro' de Machado de Assis",
  sub = "Análise realizada por Felipe Mendes",
  xlab="emoções", ylab = NULL)

palavras_tristeza <- texto_palavras[sentimentos_df$sadness > 0]
palavras_tristeza_ordem <- sort(table(unlist(palavras_tristeza)), decreasing = TRUE)
head(palavras_tristeza_ordem, n = 12)
head(palavras_tristeza_ordem, n = 12)
length(palavras_tristeza_ordem)

nuvem_emocoes_vetor <- c(
  paste(texto_palavras[sentimentos_df$sadness> 0], collapse = " "),
  paste(texto_palavras[sentimentos_df$joy > 0], collapse = " "),
  paste(texto_palavras[sentimentos_df$anger > 0], collapse = " "),
  paste(texto_palavras[sentimentos_df$fear > 0], collapse = " "))

nuvem_emocoes_vetor <- iconv(nuvem_emocoes_vetor, "latin1", "UTF-8")
nuvem_corpus <- Corpus(VectorSource(nuvem_emocoes_vetor))
nuvem_tdm <- TermDocumentMatrix(nuvem_corpus)
nuvem_tdm <- as.matrix(nuvem_tdm)
head(nuvem_tdm)

colnames(nuvem_tdm) <- c('tristeza', 'felicidade', 'raiva', 'confiança')
head(nuvem_tdm)
set.seed(757) # pode ser qualquer número
comparison.cloud(nuvem_tdm, random.order = FALSE,
                 colors = c("green", "red", "orange", "blue"),
                 title.size = 1, max.words = 50, scale = c(2.5, 1), rot.per = 0.4)

#Visualizando a evolução dos sentimentos em um texto
sentimentos_valencia <- (sentimentos_df$negative * -1) + sentimentos_df$positive
simple_plot(sentimentos_valencia)
#simple_plot(mar = c(5, 4, 4, 2) + 0.1)








