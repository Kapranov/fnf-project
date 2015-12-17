namespace :db do
  desc "Erase and fill database"
  task populate: :environment do
    # I18n.locale = :ru
    # Faker::Config.locale = 'ru'

    [Category].each(&:delete_all)


    def random_displayed
      ['true', 'false'].sample
    end

    def random_users
      ['1', '2', '3'].sample
    end

    Category.populate 9 do |category|
      category.user_id      = random_users
      category.name         = FFaker::Lorem.word
      category.description  = FFaker::HipsterIpsum.words(10).join(' ')
      # category.name         = Faker::Commerce.department
      # category.description  = Faker::Commerce.color
      category.displayed    = random_displayed
    end
  end
end
