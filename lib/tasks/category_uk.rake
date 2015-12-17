namespace :db do
  task category_uk: :environment do
    I18n.locale = :uk
    Faker::Config.locale = 'uk'

    def random_displayed
      ['true', 'false'].sample
    end

    def random_users
      ['1', '2', '3'].sample
    end

    10.times do
      Category.create(
        user_id: random_users,
        name: Faker::Commerce.department,
        description: Faker::Commerce.color,
        displayed: random_displayed
      )
    end

  end
end
