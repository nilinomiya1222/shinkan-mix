== README

* Ruby version
2.1.7

* To Do
## WHAT
会則、アピールポイントの生成

rails c

ary = ["インカレOK","オールワセダ","男は早大、女はインカレ","掛け持ち不可","掛け持ちＯＫ","随時入会可能","社会人OK","院生OK","入会審査あり","冷やかしお断り","チャラ男不可","会費なし"]

ary.each do |ele|

rule = Rule.new(name: ele)

rule.save

end

ary = ["部室あり","飲みに自信あり","飲みに自信なし","イッキ強制なし","非レギュラー制","真剣にやれる人希望","楽しむことが最優先","授業優先","初心者歓迎","経験者歓迎","経験者多数","完全プロ志向","即レギュラー可能","実績がウリ","将来性あり","機材が充実","強さが自慢","プロの指導あり","少数精鋭","まったり系","サークル内恋愛奨励","上下関係なし","体育会系","来る者拒まず去る者追わず","オールイケメン","マネージャー歓迎","留学生歓迎","雀士歓迎","コミュ障歓迎","オタク歓迎","貧乏歓迎","喫煙者歓迎","留年歓迎","多浪歓迎","一人暮らし歓迎","腐女子歓迎","コネバイトあり","就職に有利","テスト時有利","合コン多数あり","イベント多数","いわゆる12大サークル","もっと評価されるべき","2015年度新設","2016年度新設(予定)"]

q

ary.each do |ele|

ap = AppealPoint.new(name: ele)

ap.save

end

q

exit

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Please feel free to use a different markup language if you do not plan to run
<tt>rake doc:app</tt>.
