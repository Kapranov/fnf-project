=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end

require 'progress_bar'

##############################
# Roles
##############################
User.destroy_all
Role.destroy_all
Role.create!(
  name: :simple_customer,
  title: :role_for_simple_customer,
  description: :user_can_edit_his_pages,
  the_role: {
    companies: {
      index:   false,
      show:    false,
      new:     false,
      create:  false,
      edit:    false,
      update:  false,
      destroy: false
    },
    trademarks: {
      index:   false,
      show:    false,
      new:     false,
      create:  false,
      edit:    false,
      update:  false,
      destroy: false
    },
    products: {
      index:   false,
      show:    false,
      new:     false,
      create:  false,
      edit:    false,
      update:  false,
      destroy: false
    },
    users: {
      index:   false,
      show:    false,
      new:     true,
      create:  true,
      edit:    false,
      update:  false,
      destroy: false
    }
  }
)
Role.create!(
  name: :manufacturer,
  title: :role_for_manufacturer,
  description: :user_can_edit_his_pages,
  the_role: {
    companies: {
      index:   true,
      show:    true,
      new:     true,
      create:  true,
      edit:    true,
      update:  true,
      destroy: false
    },
    trademarks: {
      index:   true,
      show:    true,
      new:     true,
      create:  true,
      edit:    true,
      update:  true,
      destroy: false
    },
    products: {
      index:   true,
      show:    true,
      new:     true,
      create:  true,
      edit:    true,
      update:  true,
      destroy: false
    },
    users: {
      index:   false,
      show:    false,
      new:     true,
      create:  true,
      edit:    false,
      update:  false,
      destroy: false
    }
  }
)
Role.create!(
  name: :distributor,
  title: :role_for_distributor,
  description: :user_can_edit_his_pages,
  the_role: {
    companies: {
      index:   true,
      show:    true,
      new:     true,
      create:  true,
      edit:    true,
      update:  true,
      destroy: false
    },
    trademarks: {
      index:   true,
      show:    true,
      new:     true,
      create:  true,
      edit:    true,
      update:  true,
      destroy: false
    },
    products: {
      index:   true,
      show:    true,
      new:     true,
      create:  true,
      edit:    true,
      update:  true,
      destroy: false
    },
    users: {
      index:   false,
      show:    false,
      new:     true,
      create:  true,
      edit:    false,
      update:  false,
      destroy: false
    }
  }
)
Role.create!(
  name: :moderator,
  title: :role_for_moderator,
  description: :user_can_edit_his_pages,
  the_role: {
    companies: {
      index:   true,
      show:    true,
      new:     true,
      create:  true,
      edit:    true,
      update:  true,
      destroy: false
    },
    trademarks: {
      index:   true,
      show:    true,
      new:     true,
      create:  true,
      edit:    true,
      update:  true,
      destroy: false
    },
    products: {
      index:   true,
      show:    true,
      new:     true,
      create:  true,
      edit:    true,
      update:  true,
      destroy: false
    },
    users: {
      index:   false,
      show:    false,
      new:     true,
      create:  true,
      edit:    false,
      update:  false,
      destroy: false
    }
  }
)
Role.create!(
  name: :operator,
  title: :role_for_operators,
  description: :user_can_edit_his_pages,
  the_role: {
    
    clients: {
      index:   false,
      show:    false,
      new:     false,
      create:  false,
      edit:    false,
      update:  false,
      destroy: false
    },
    requests: {
      index:   false,
      show:    false,
      new:     false,
      create:  false,
      edit:    false,
      update:  false,
      destroy: false
    },
    users: {
      index:   false,
      show:    false,
      new:     true,
      create:  true,
      edit:    false,
      update:  false,
      destroy: false
    }
  }
)
puts "Roles created"

TheRole.create_admin!
puts "admin role created"
# TheRole.create_admin_role!
#puts "dont forget enter command rake db:the_role:admin for create Admin role"
#rake db:the_role:admin



def get_file(name, content_type = 'image/jpeg')
  file = ActionDispatch::Http::UploadedFile.new(:tempfile => File.open(File.join(Rails.application.root, 'db', 'seeds_data', name), 'rb'))
  file.original_filename = name
  file.content_type = content_type
  file
end

##############################
# Users
##############################
User.create!(
  email: 'andrey.z@zettheme.com',
  first_name: 'Андрей',
  last_name: 'Жук',
  province: 'UA32',
  city: 'Киев',
  password: 'qwertyqwerty',
  password_confirmation: 'qwertyqwerty',
  post: 'Основатель & Генеральный директор',
  about: 'Организовую работу команды. Обеспечиваую качественный результат и оправдание ожиданий клиентов.',
  avatar: get_file("andrey-zhuk.jpg"),
  role: Role.with_name(:admin)
)

User.create!(
  email: 'olga.m@zettheme.com',
  first_name: 'Ольга',
  last_name: 'Мартынюк',
  province: 'UA32',
  city: 'Киев',
  password: 'qwertyqwerty',
  password_confirmation: 'qwertyqwerty',
  post: 'Заместитель директора & Руководитель проектов',
  about: 'Отвечаю за создание функциональных сайтов. Руководит командой разработчиков.',
  role: Role.with_name(:operator)
)

User.create!(
  email: 'aleksandr.s@zettheme.com',
  first_name: 'Александр',
  last_name: 'Семёнов',
  province: 'UA32',
  city: 'Киев',
  password: 'qwertyqwerty',
  password_confirmation: 'qwertyqwerty',
  post: 'Разработчик',
  about: 'Выполняю задачи разных уровней сложности с целью создания продающих, удобных и красивых сайтов.',
  role: Role.with_name(:moderator)
)
puts "employees is createds"

User.create!(
  email: 'manufacturer@test.com',
  first_name: 'Александр',
  last_name: 'Семёнов',
  province: 'UA32',
  city: 'Киев',
  password: 'qwertyqwerty',
  password_confirmation: 'qwertyqwerty',
  post: 'Директор',
  about: 'Выполняю задачи разных уровней сложности с целью создания продающих, удобных и красивых сайтов.',
  role: Role.with_name(:manufacturer)
)
puts "manufacturer is created"
User.create!(
  email: 'distributor@test.com',
  first_name: 'Александр',
  last_name: 'Семёнов',
  province: 'UA32',
  city: 'Киев',
  password: 'qwertyqwerty',
  password_confirmation: 'qwertyqwerty',
  post: 'Директор',
  about: 'Выполняю задачи разных уровней сложности с целью создания продающих, удобных и красивых сайтов.',
  role: Role.with_name(:distributor)
)
puts "distributor is created"
User.create!(
  email: 'simple_customer@test.com',
  first_name: 'Александр',
  last_name: 'Семёнов',
  province: 'UA32',
  city: 'Киев',
  password: 'qwertyqwerty',
  password_confirmation: 'qwertyqwerty',
  post: 'Учитель',
  about: 'Выполняю задачи разных уровней сложности с целью создания продающих, удобных и красивых сайтов.',
  role: Role.with_name(:simple_customer)
)
puts "simple customer is created"

#if !Rails.env.production?
  
  lorem = 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'

  # pro = Shoppe::Product.new(:name => 'Yealink T20P', :sku => 'YL-SIP-T20P', :description => lorem, :short_description => 'If cheap & cheerful is what you’re after, the Yealink T20P is what you’re looking for.', :weight => 1.119, :price => 54.99, :cost_price => 44.99, :tax_rate => tax_rate, :featured => true)
  # pro.product_category_ids = cat1.id
  # pro.default_image_file = get_file('t20p.jpg')

  # first_name = Faker::Name.first_name
  # last_name = Faker::Name.last_name
  password = Faker::Internet.password(8)

  20.times do
    user = User.create!(
      email: Faker::Internet.safe_email,
      password: password,
      password_confirmation: password,
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      province: Faker::Address.city,
      city: Faker::Address.city,
      avatar: get_file("avatar-#{[*1..3].sample}.png"),
      role: [Role.with_name(:moderator), Role.with_name(:operator), Role.with_name(:distributor), Role.with_name(:manufacturer), Role.with_name(:simple_customer)].sample,
      about: lorem,
      post: 'Директор'
    )
    puts "Пользователь #{user.first_name} создан с ролью #{I18n.t(user.role_name, scope: '.role_name')}"
  end
  puts "Пользователи созданны"
  
  # https://github.com/greyblake/fast_seeder for method to import real categories
  # roots categories
  puts "Создание категорий"
  Category.create!(
    image: get_file("categories/Продукты питания.jpg"),
    name: "Продукты питания",
    description: "высококалорийные и легкоусваиваемые пищевые продукты с большим содержанием сахара, отличающиеся приятным вкусом и ароматом. В качестве основного сырья для приготовления кондитерских изделий используются следующие виды продуктов: мука (пшеничная, реже кукурузная, рисовая, овсяная и др.), сахар, мёд, фрукты и ягоды, молоко и сливки, жиры, яйца, дрожжи, крахмал, какао, орехи, пищевые кислоты, желирующие вещества, вкусовые и ароматические добавки, пищевые красители и разрыхлители.",
    meta_title: "Мясо — скелетная поперечно-полосатая мускулатура животного",
    meta_keywords: "Мясо",
    meta_description: "Продукты питания, напитки. Продажа, поиск, поставщики  Украине."
  )

  Category.create!(
    image: get_file("categories/Мясо.jpg"),
    name: "Мясо",
    description: "Мя́со — скелетная поперечно-полосатая мускулатура животного с прилегающими к ней жировой и соединительной тканями, а также прилегающей костной тканью или без неё.",
    parent_id: 1,
    meta_title: "Мя́со — скелетная поперечно-полосатая мускулатура животного",
    meta_keywords: "Мясо",
    meta_description: "Мя́со — скелетная поперечно-полосатая мускулатура животного с прилегающими к ней жировой и соединительной тканями"
  )
  Category.create!(
    image: get_file("categories/Мясо птицы.png"),
    name: "Мясо птицы",
    description: "Мясо — скелетная поперечно-полосатая мускулатура животного с прилегающими к ней жировой и соединительной тканями, а также прилегающей костной тканью или без неё.",
    parent_id: 1,
    meta_title: "Мясо — скелетная поперечно-полосатая мускулатура животного",
    meta_keywords: "Мясо",
    meta_description: "Мя́со — скелетная поперечно-полосатая мускулатура животного с прилегающими к ней жировой и соединительной тканями"
  )

  Category.create!(
    image: get_file("categories/Кондитерские изделия.jpg"),
    name: "Кондитерские изделия",
    description: "высококалорийные и легкоусваиваемые пищевые продукты с большим содержанием сахара, отличающиеся приятным вкусом и ароматом. В качестве основного сырья для приготовления кондитерских изделий используются следующие виды продуктов: мука (пшеничная, реже кукурузная, рисовая, овсяная и др.), сахар, мёд, фрукты и ягоды, молоко и сливки, жиры, яйца, дрожжи, крахмал, какао, орехи, пищевые кислоты, желирующие вещества, вкусовые и ароматические добавки, пищевые красители и разрыхлители.",
    parent_id: 1,
    meta_title: "Мясо — скелетная поперечно-полосатая мускулатура животного",
    meta_keywords: "Мясо",
    meta_description: "Мя́со — скелетная поперечно-полосатая мускулатура животного с прилегающими к ней жировой и соединительной тканями"
  )
  bar = ProgressBar.new(10)
  10.times do
    Category.create!(
        image: get_file("categories/#{[*1..8].sample}.jpg"),
        name: Faker::Commerce.department,
        description: Faker::Lorem.paragraph,
        meta_title: Faker::Commerce.product_name,
        meta_keywords: Faker::Lorem.words,
        meta_description: Faker::Lorem.paragraph
    )
    bar.increment!
  end

  # childs categories

  bar = ProgressBar.new(10)
  10.times do
    Category.create!(
      image: get_file("categories/#{[*1..8].sample}.jpg"),
      name: Faker::Commerce.department,
      description: Faker::Lorem.paragraph,
      parent_id: [*1..10].sample,
      meta_title: Faker::Commerce.product_name,
      meta_keywords: Faker::Lorem.words,
      meta_description: Faker::Lorem.paragraph
    )
    bar.increment!
  end
  # This is necessary to update :lft and :rgt columns
  #Category.rebuild!
  puts "Категории созданны"
   
  
  company = Company.create!(
    user_id: 1,
    name: 'Zettheme',
    description: 'Дизайн и разработка сайтов, создание профессиональных веб-приложений, решений для электронной коммерции и многого другое - для нас не проблема',
    business_entity: "LTD",
    vatcode: "555228545",
    company_id_number: "555228545",
    registration_date: Time.now,
    cea: "555228545",
    type_company: "manufacturer",
    country: Faker::Address.country,
    province: Faker::Address.city,
    city: Faker::Address.city,
    address: Faker::Address.street_address,
    website: Faker::Internet.domain_name,
    meta_title: "Веб студия Zettheme (Зеттем) - создание сайтов и разработка интернет магазинов",
    meta_keywords: "Зеттем, веб студия, создание сайтов, разработка сайтов, Веб Дизайн",
    meta_description: "Веб Студия Zettheme: Создание Сайтов Киев, Веб Дизайн, Продвижение Сайта. Консультации по тел.:+380 96-95-75-293",
    logo: get_file("logos/1.png"),
    state: :pending
  )
  # company.state_event = "to_publish".save
  puts "Компания Zettheme создана"
  
  company = Company.create!(
    user_id: 2,
    name: 'Сильпо',
    description: 'Супермаркеты «Сильпо» — это магазины самообслуживания, ассортимент которых насчитывает до 20 тыс. наименований продуктов питания и сопутствующих товаров в зависимости от величины торговой площади объекта. На Украине «Сильпо» является одной из наиболее крупных торговых сетей. 14 февраля открылся 238-й супермаркет сети. Они есть в каждой области Украины и автономной республике Крым[1] Сеть супермаркетов «Сильпо» входит в торгово-промышленную группу компаний Украины — «Fozzy Group».',
    business_entity: "LTD",
    vatcode: "555228545",
    company_id_number: "555228545",
    registration_date: Time.now,
    cea: "555228545",
    type_company: "manufacturer",
    country: Faker::Address.country,
    province: Faker::Address.city,
    city: Faker::Address.city,
    address: Faker::Address.street_address,
    website: Faker::Internet.domain_name,
    meta_title: "Супермаркеты Сильпо",
    meta_keywords: "Супермаркеты Сильпо, Сильпо",
    meta_description: "Супермаркеты «Сильпо» — это магазины самообслуживания, ассортимент которых насчитывает до 20 тыс. ",
    logo: get_file("logos/1.png"),
    state: :pending
  )
  # company.state_event = "to_publish".save
  puts "Компания Сильпо создана"
  bar = ProgressBar.new(10)
  10.times do
    company = Company.create!(
      user_id: [*1..10].sample,
      name: Faker::Company.name,
      description: lorem,
      business_entity: "LTD",
      vatcode: Faker::Company.ein,
      company_id_number: Faker::Company.ein,
      registration_date: Time.now,
      logo: get_file("logos/#{[*1..2].sample}.png"),
      cea: "555228545",
      type_company: "manufacturer",
      address: Faker::Address.street_address,
      website: Faker::Internet.domain_name,
      meta_title: Faker::Company.name,
      meta_keywords: "Супермаркеты Сильпо, Сильпо",
      meta_description: "Супермаркеты «Сильпо» — это магазины самообслуживания, ассортимент которых насчитывает до 20 тыс. ",
      state: :pending
    )
    #company.state_event = "to_publish".save
    puts "Company #{company.name} создана"
  end
  10.times do
    trademark = Trademark.create!(
      user_id: [*1..10].sample,
      company_id: [*1..10].sample,
      logo: get_file("logos/#{[*1..2].sample}.png"),
      name: Faker::Company.name,
      description: 'Супермаркеты «Сильпо» — это магазины самообслуживания, ассортимент которых насчитывает до 20 тыс. наименований продуктов питания и сопутствующих товаров в зависимости от величины торговой площади объекта. На Украине «Сильпо» является одной из наиболее крупных торговых сетей. 14 февраля открылся 238-й супермаркет сети. Они есть в каждой области Украины и автономной республике Крым[1] Сеть супермаркетов «Сильпо» входит в торгово-промышленную группу компаний Украины — «Fozzy Group».',
    )
    bar.increment!
    puts "Торговая марка #{trademark.name} создана"
  end

  trademark = Trademark.create!(
    user_id: 1,
    company_id: 2,
    logo: get_file("logos/#{[*1..2].sample}.png"),
    name: Faker::Company.name,
    description: 'Супермаркеты «Сильпо» — это магазины самообслуживания, ассортимент которых насчитывает до 20 тыс. наименований продуктов питания и сопутствующих товаров в зависимости от величины торговой площади объекта. На Украине «Сильпо» является одной из наиболее крупных торговых сетей. 14 февраля открылся 238-й супермаркет сети. Они есть в каждой области Украины и автономной республике Крым[1] Сеть супермаркетов «Сильпо» входит в торгово-промышленную группу компаний Украины — «Fozzy Group».',
  )
  puts "Торговая марка #{trademark.name} создана"
  trademark = Trademark.create!(
    user_id: 1,
    company_id: 1,
    logo: get_file("logos/#{[*1..2].sample}.png"),
    name: Faker::Company.name,
    description: 'Супермаркеты «Сильпо» — это магазины самообслуживания, ассортимент которых насчитывает до 20 тыс. наименований продуктов питания и сопутствующих товаров в зависимости от величины торговой площади объекта. На Украине «Сильпо» является одной из наиболее крупных торговых сетей. 14 февраля открылся 238-й супермаркет сети. Они есть в каждой области Украины и автономной республике Крым[1] Сеть супермаркетов «Сильпо» входит в торгово-промышленную группу компаний Украины — «Fozzy Group».',
  )
  puts "Торговая марка #{trademark.name} создана"

  10.times do
    Product.create!(
      user_id: [*1..10].sample,
      category: Category.find(5),
      company_id: 1,
      trademark: Trademark.find(5),
      name: Faker::Commerce.product_name,
      ean13: [*200..999].sample,
      price: Faker::Commerce.price,
      reference: [*1000..20000].sample,
      description: Faker::Lorem.paragraph,
      status: ["published", "draft"].sample,
      meta_title: Faker::Commerce.product_name,
      meta_keywords: Faker::Lorem.words,
      meta_description: Faker::Lorem.paragraph
    )
    product_id = Product.last.id
    3.times do
      ProductImage.create!(
        product_id: product_id,
        image: get_file("#{[*1..10].sample}.jpg")
      )
    end
  end

  20.times do
    product = Product.create!(
      user_id: [*1..10].sample,
      category: Category.find(5),
      company_id: 2,
      trademark: Trademark.find(5),
      name: Faker::Commerce.product_name,
      ean13: [*10..20].sample,
      price: Faker::Commerce.price,
      reference: [*1000..20000].sample,
      supplier_reference: [*1000..20000].sample,
      description: Faker::Lorem.paragraph,
      status: ["published", "draft"].sample,
      meta_title: Faker::Commerce.product_name,
      meta_keywords: Faker::Lorem.words,
      meta_description: Faker::Lorem.paragraph
    )
    puts "Товар #{product.name} создан"
    product_id = Product.last.id
    3.times do
      ProductImage.create!(
        product_id: product_id,
        image: get_file("#{[*1..10].sample}.jpg")
      )
    end
  end
  puts "Все продукты создались"

  puts "Все задания в сидах выполнины"

  
 

#end #Rails.env.production?