# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


PeriodPost.destroy_all
Post.destroy_all
Period.destroy_all
User.destroy_all

User.create([
  {first_name:"Admin",last_name:"User",email:"admin@time.com",image:"http://donatered-asset.s3.amazonaws.com/assets/default/default_user-https://i.ytimg.com/vi/sWprbfWpy9E/hqdefault.jpg", password: "password"},
  {first_name:"Justin",last_name:"Timberlake",email:"jt@jt.com",image:"http://donatered-asset.s3.amazonaws.com/assets/default/default_user-884fcb1a70325256218e78500533affb.jpg", password: "password"},
  {first_name:"Annabelle",last_name:"Thaddeus",email:"abt@gotexas.com",image:"http://donatered-asset.s3.amazonaws.com/assets/default/default_user-884fcb1a70325256218e78500533affb.jpg", password: "password"}
  ])

Post.create!([
  {title:"The Great San Francisco Earthquake",description:"One morning, when Gregor Samsa woke from troubled dreams, he found himself transformed in his bed into a horrible .",
image:"http://earthquake.usgs.gov/regional/nca/1906/18april/images/sfburning.gif", post_date: Date.new(1906,4,18)},
  {title:"Woodstock",description:"Not a sunrise but a galaxyrise? Corpus callosum galaxies from which we spring Euclid dispassionate extraterrestrial observer Jean-François .",
image:"http://jessicaharper.com/cms/wp-content/uploads/2015/04/Woodstock2.jpg",post_date:Date.new(1969,8,15)},
  {title:"First Telegraphic Message",description:"What Hath God Wrought?  Bits of moving fluff concept of the number one the only home we've ever known radio telescope. Laws .",
image:"http://www.telegraph-office.com/bw_images/bunnell_mechanical.jpg",post_date:Date.new(1844,5,24)},
  {title:"Alexander conquers Eqypt",description:"Stirred by starlight tendrils of gossamer clouds Vangelis at the edge of forever Cambrian explosion. Globular star cluster .",
image:"http://www.mitchellteachers.org/WorldHistory/AncientGreece/Images/AlexanderSphinxGizaTrans.jpg",post_date:Date.new(-332,1,1)}
])


Period.create!([
 {name:"Machine Age",start_time:Date.new(1880), end_time:Date.new(1945),
description:"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore.",
image:"https://rosswolfe.files.wordpress.com/2011/09/the-machine-age-3pc.jpg"},
 {name:"World War I",start_time:Date.new(1914), end_time:Date.new(1918),
description:"The quick, brown fox jumps over a lazy dog. DJs flock by when MTV ax quiz prog. Junk MTV quiz graced by fox whelps. Bawds jog, flick quartz, vex nymph.",
image:"https://images2.storyjumper.com/transcoder.png?trim&id=d1-tele2b76k-55zwjxjaf&maxw=256&maxh=256"},
 {name:"Roaring Twenties",start_time:Date.new(1920), end_time:Date.new(1929),
description:"A wonderful serenity has taken possession of my entire soul, like these sweet mornings of spring which I enjoy with my whole heart. I am alone, and fe.",
image:"https://pbs.twimg.com/profile_images/418839715312181248/d9fDpwke.jpeg"},
 {name:"Victorian Era",start_time:Date.new(1837), end_time:Date.new(1901),
description:"Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. Separated they live in Bookmarksg.",
image:"https://65.media.tumblr.com/avatar_36e2885e34ab_128.png"},
 {name:"Ancient Times",start_time:Date.new(-4700), end_time:Date.new(425),
description:"Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. Por scientie, musica, sport etc, litot Europa usa li sam vocabular.",
image:"http://images.wildtangent.com/ancientrome/big_icon.jpg"}
])

@users = User.all
@posts = Post.all
@periods = Period.all

## admin, user 0, will not be added to any posts or periods
## admin user is only for inhereting content from deleted users
@posts[0].user_id = @users[1].id
@posts[1].user_id = @users[1].id
@posts[2].user_id = @users[2].id
@posts[3].user_id = @users[2].id

@posts.each do |post|
  @periods.each do |period|
    if period.start_time < post.post_date && period.end_time >= post.post_date
      PeriodPost.create!({period_id: period.id,post_id:post.id})
    end
  end
  post.save
end

@periods[0].user_id = @users[1].id
@periods[1].user_id = @users[1].id
@periods[2].user_id = @users[2].id
@periods[3].user_id = @users[2].id
@periods[4].user_id = @users[1].id

@periods.each do |period|
  period.save
end




