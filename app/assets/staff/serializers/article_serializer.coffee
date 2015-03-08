Kicker.ArticleSerializer = DS.ActiveModelSerializer.extend(DS.EmbeddedRecordsMixin,
  attrs:
    section:
      embedded: 'always'
    subsection:
      embedded: 'always'
    articleType:
      embedded: 'always'
)