# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(password: 'itsuki0208', email: 'test@test.com')

Gerne.create!(
  [
    {name: 'ケーキ',
     id:2
    },
    {name: 'プリン',
     id:1,
    },
    {name: 'クッキー',
     id:3,
    },
    {name: '洋菓子',
     id:4,
    },
    {name: '和菓子',
     id:5,
    },
    {name: 'アイスクリーム',
     id:6,
    },
  ]
  )
    

Item.create!(genre_id:1, name:"チョコレートケーキ", introduction:" 外はサクッと中はとろっと！", price:¥650)

Item.create!(genre_id:1, name:"ショートケーキ", introduction:"十勝産の牛乳をふんだんに使用しております。", price:¥400)

Item.create!(genre_id:1, name:"にんじんケーキ", introduction:" 長野名物の人参をいっぱい！", price:¥250)

Item.create!(genre_id:1, name:"モンブラン", introduction:" 栗の味が口の中いっぱいに！", price:¥650)

