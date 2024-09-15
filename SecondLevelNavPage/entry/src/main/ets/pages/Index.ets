import ClassifyModel from '../viewmodels/ClassifyModel';
import ClassifyViewModel from '../viewmodels/ClassifyViewModel'
import CourseModel from '../viewmodels/CourseModel';
import LinkDataModel from '../viewmodels/LinkDataModel';

@Entry
@Component
struct Index {
  classifyScroller: Scroller = new Scroller()
  courseScroller: Scroller = new Scroller()
  @State selectedIndex: number = 0

  aboutToAppear() {
    let data = ClassifyViewModel.getLinkData()
    console.log('[SecLevelNavPage] >> data:',JSON.stringify(data))
  }

  classifyAction(index: number, isClassify: boolean) {
    this.selectedIndex = index
    if (isClassify) {
      console.log('[vinlor] >>classifyAction>> courseScroller: ',index)
      this.courseScroller.scrollToIndex(index)
    } else  {
      console.log('[vinlor] >>!classifyAction>> classifyScroller: ',index)
      this.classifyScroller.scrollToIndex(index)
    }
  }

  build() {
    Row() {
      List({scroller: this.classifyScroller}) {
        ForEach(ClassifyViewModel.getLinkData(),(item: ClassifyModel, index?: number)=>{
          ListItem() {
            Text(item.parentName)
              .fontSize('14vp')
              .fontColor(this.selectedIndex === index ? '#182431' : '#99182431')
              .backgroundColor(this.selectedIndex === index ? '#F1F3F5' : '')
              .fontFamily(this.selectedIndex === index ? 'HarmonyHeiTi-Medium' : 'HarmonyHeiTi')
              .width('100%')
              .height('56vp')
              .fontWeight(400)
              .textAlign(TextAlign.Center)
              .onClick(()=>{
                if (index !== undefined) {

                  this.classifyAction(index, true)
                }

              })
          }

        })

      }
      .width('100vp')
      .height('100%')
      .backgroundColor('#0D182431')
      
      List({scroller: this.courseScroller}) {
        ForEach(ClassifyViewModel.getLinkData(),(item: ClassifyModel)=>{
          ListItemGroup({
            header: this.ClassifyHeader(item.parentName),
            space: 12
          }) {
            ForEach(item.courseList,(item: CourseModel)=>{
              ListItem() {
                Row() {
                  Image(item.imageUrl)
                    .height('100%')
                    .aspectRatio(1)

                  Column() {
                    Text(item.courseName)
                      .fontSize('14fp')
                      .fontColor('#182431')
                      .fontFamily('HarmonyHeiTi-Medium')
                      .maxLines(2)
                      .textOverflow({overflow: TextOverflow.Ellipsis})
                      .width('100%')
                      .lineHeight('20vp')

                    Text(`¥ ${item.price}`)
                  }
                  .padding('12vp')
                  .justifyContent(FlexAlign.SpaceBetween)
                  .alignItems(HorizontalAlign.Start)
                  .height('100%')
                  // .width('100%')
                  .layoutWeight(1)
                }
                .clip(true)
                .borderRadius('18vp')
                .width('100%')
                .height('96vp')
                .backgroundColor('#FFFFFF')

              }
              .margin({bottom: '12vp'})
            })
          }

        })
      }
      // .width('100%')
      .height('100%')
      .padding({left: '8vp', right: '12vp'})
      .layoutWeight(1)
      .onScrollIndex((start: number)=>{
        console.log('[vinlor] >> start: ', start)
        this.classifyAction(start, false)

      })

    }
    .height('100%')
    .width('100%')
    .backgroundColor('#F1F3F5')
  }

  @Builder ClassifyHeader(courseName: string) {
    Row() {
      Text(courseName)
        .fontSize('18fp')
        .fontWeight(500)
        .fontColor('##182431')
        .fontFamily('HarmonyHeiTi-Medium')
    }
    .height('56vp')
    .padding({left: 8})
    .width('100%')
    .backgroundColor('#F1F3F5')

  }
}