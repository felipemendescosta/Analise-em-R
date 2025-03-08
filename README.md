# Análise de Sentimento do Livro *Dom Casmurro* de Machado de Assis

Este projeto realiza uma análise de sentimentos do livro *Dom Casmurro* de Machado de Assis utilizando a linguagem R. Foram aplicadas técnicas de processamento de linguagem natural (NLP) para identificar as emoções presentes no texto.

## Tecnologias Utilizadas

- R
- Pacotes: `syuzhet`, `RColorBrewer`, `wordcloud`, `tm`

## Instalação dos Pacotes

Antes de iniciar a execução do código, instale os pacotes necessários:

```r
install.packages("syuzhet")
install.packages("RColorBrewer")
install.packages("wordcloud")
install.packages("Rtools")
install.packages("tm")
```

## Execução

1. **Carregue os pacotes**

```r
library(syuzhet)
library(RColorBrewer)
library(wordcloud)
library(tm)
```

2. **Carregue o texto do livro**

```r
texto <- scan(file = "https://raw.githubusercontent.com/programminghistorian/jekyll/gh-pages/assets/domCasmurro.txt", fileEncoding = "UTF-8", what = character(), sep = "\n", allowEscapes = T)
```

3. **Tokenização e Extração de Sentimentos**

```r
texto_palavras <- get_tokens(texto)
sentimentos_df <- get_nrc_sentiment(texto_palavras, lang="portuguese")
```

4. **Visualização dos Sentimentos**

- **Gráfico de Barras**

```r
barplot(
  colSums(prop.table(sentimentos_df[, 1:8])),
  space = 0.1,
  horiz = FALSE,
  las = 1,
  cex.names = 0.7,
  col = brewer.pal(n = 8, name = "Set3"),
  main = "'Dom Casmurro' de Machado de Assis",
  sub = "Análise realizada por Felipe Mendes",
  xlab="Emoções"
)
```

- **Nuvem de Palavras**

```r
nuvem_corpus <- Corpus(VectorSource(nuvem_emocoes_vetor))
nuvem_tdm <- TermDocumentMatrix(nuvem_corpus)
nuvem_tdm <- as.matrix(nuvem_tdm)
colnames(nuvem_tdm) <- c('tristeza', 'felicidade', 'raiva', 'confiança')


comparison.cloud(nuvem_tdm, random.order = FALSE,
                 colors = c("green", "red", "orange", "blue"),
                 title.size = 1, max.words = 50, scale = c(2.5, 1), rot.per = 0.4)
```
![Gráfico de Sentimentos](img/por%20no%20readme.png)

- **Evolução dos Sentimentos ao longo do Texto**

```r
sentimentos_valencia <- (sentimentos_df$negative * -1) + sentimentos_df$positive
simple_plot(sentimentos_valencia)
```
![Gráfico de Sentimentos](img/Rplot01.png)
## Resultado

A análise demonstrou a presença de diversas emoções ao longo do texto de *Dom Casmurro*, permitindo uma compreensão mais aprofundada sobre a atmosfera emocional do livro.

---

### Autor
Felipe Mendes


