export default class NewsData {
  title: string = ''
  content: string = ''
  imagesUrl: Array<object>
  source: string = ''

  constructor(title: string, content: string, imagesUrl: Array<object>, source: string) {
    this.title = title
    this.content = content
    this.imagesUrl = imagesUrl
    this.source = source
  }
}