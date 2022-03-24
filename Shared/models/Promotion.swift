//
//  Promotion.swift
//  Palo
//
//  Created by Hau Huynh on 18/12/2021.
//

import Foundation

struct Promotion: Codable, Identifiable, Hashable {
    let id, name, idMovie, dateCreate: String
    let length: String
    let image: String
}

var fakePromotions = [
    Promotion(id:"1",name:"Best Picture Oscar 2019: Parasite",idMovie:"1",dateCreate:"2021-12-06",length:"100",image:"https://thegioidienanh.vn/stores/news_dataimages/nguyenthithanhthuy/112019/11/21/2638_PRS.jpg"),
    Promotion(id:"2",name:"Little Women (2019)",idMovie:"2",dateCreate:"2021-12-06",length:"100",image:"https://cdn.vox-cdn.com/thumbor/JtK1Fk3q29uiaM7PMt0La-IdGJw=/0x0:1740x1107/1200x800/filters:focal(753x125:1031x403)/cdn.vox-cdn.com/uploads/chorus_image/image/66159664/Little_Women.0.jpg"),
    Promotion(id:"3",name:"Hotel Mumbai (2019): Real Event",idMovie:"4",dateCreate:"2021-12-06",length:"100",image:"https://i.ytimg.com/vi/A8IxhVslvro/maxresdefault.jpg")
]
