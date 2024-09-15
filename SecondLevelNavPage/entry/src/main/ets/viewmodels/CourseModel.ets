export default class CourseModel {
  id: number
  courseName: string
  price: number
  imageUrl: Resource
  parentId: number

  constructor(id: number, courseName: string, price: number, imageUrl: Resource, parentId: number) {
    this.id = id
    this.courseName = courseName
    this.price = price
    this.imageUrl = imageUrl
    this.parentId = parentId
  }
}