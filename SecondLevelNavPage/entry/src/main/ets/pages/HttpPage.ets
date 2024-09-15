import { http } from '@kit.NetworkKit';
import  NewsData  from '../models/NewsData'

const SERVER = 'http://192.168.3.50:9588/'

@Entry
@Component
struct HttpPage {
  @State message: string = 'Hello World';


  @State dataSource: Array<NewsData> = []

  aboutToAppear(): void {
    this.testHttp()
  }

  testHttp() {
    let createHttp = http.createHttp()

    let responseResult = createHttp.request(`${SERVER}new/getNewsList`,{
      method: http.RequestMethod.GET,
      readTimeout: 5000,
      header: {
        'Content-Type': 'application/json',
      },
      connectTimeout: 5000,
      extraData: {
        'account': '123',
        'password': '456'
      }
    })

    responseResult.then((value: http.HttpResponse)=>{

      console.log('[vinlor] >>testHttp: ',JSON.stringify(value))
      if (value?.responseCode === 200) {
        let result = `${value?.result}`
        let resultJson: ResponseResult = JSON.parse(result);
        console.log('[vinlor] >>testHttp responseObj: ',JSON.stringify(resultJson))
        if (resultJson?.code === 'success') {
          for (let index = 0; index < resultJson?.data.length; index++) {
            const item: NewsData = resultJson?.data[index];
            this.dataSource.push(item)
          }
        }
        console.log('[vinlor] >>testHttp dataSource: ',JSON.stringify(this.dataSource))
      }
      
    })
      .catch((err: Error)=>{
        console.log('[vinlor] >>testHttp >>err: ', JSON.stringify(err))
      })
  }

  build() {
    RelativeContainer() {
      List(){
        ForEach(this.dataSource,(item: NewsData)=>{
          ListItem() {
            Column() {
              Row(){
                Text('新闻')
                  .fontColor('#1B8AFF')
                  .backgroundColor('#FFFFFF')
                  .borderWidth('2')
                  .width('12%')
                  .textAlign(TextAlign.Center)
                  .borderRadius(4)
                  .borderColor('#1B8AFF')
                  .fontSize('12')
                  .height('22')
                Text(item.title)
                  .margin({left: '12'})
                  .fontSize('18')
                  .fontWeight(500)
              }
              .justifyContent(FlexAlign.Start)
              .width('100%')
              .padding({left: '12'})

              Text(item.content)
                .fontSize('14')
                .maxLines(2)
                .textOverflow({overflow: TextOverflow.Ellipsis})
                .padding({left: '12', right: '12', top: '12'})

              Grid() {
                ForEach(item.imagesUrl,(image: object)=>{
                  GridItem(){
                    Image(SERVER + image['url'])
                      .borderRadius(8)
                      .objectFit(ImageFit.Cover)
                  }

                })
              }
              .columnsTemplate('1fr '.repeat(item.imagesUrl.length))
              .rowsTemplate('1fr')
              .columnsGap(5)
              .margin({
                left: '3.5%',
                right: '3.5%',
                top: '5.1%'
              })
              // .width('93%')
              .height('31.5%')

              Text(item.source)
            }
          }
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .margin({top: '12'})
          .height('32%')
          // .padding({left: '12', right: '12'})
        })
      }
    }
    .backgroundColor('#F1F3F5')
    .height('100%')
    .width('100%')
  }
}

class ResponseResult {
  code: string
  data:[]
  msg: string

  constructor() {
    this.code = ''
    this.data = []
    this.msg = ''
  }
}