export default class LinkDataModel {
  parentId: number = 0
  parentName: string = ''
  id: number = 0
  name: string = ''
  imageUrl: Resource
  price: number

  constructor(parentId: number, parentName: string, id: number, name: string, imageUrl: Resource, price: number) {
    this.parentId = parentId
    this.parentName = parentName
    this.id = id
    this.name = name
    this.imageUrl = imageUrl
    this.price = price
  }
}