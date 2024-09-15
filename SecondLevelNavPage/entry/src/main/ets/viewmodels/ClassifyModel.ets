import CourseModel from './CourseModel'

export default class ClassifyModel {
  id: number = 0
  parentName: string = ''
  courseList: Array<CourseModel> = []

  constructor(id: number, parentName: string, courseList: Array<CourseModel>) {
    this.id = id
    this.parentName = parentName
    this.courseList = courseList
  }
}