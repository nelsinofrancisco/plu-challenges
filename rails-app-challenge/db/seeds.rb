# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

districts = ['Itaim Bibi', 'Moema', 'Liberdade', 'Rochdale', 'Osasco']
streets = ['Rua 1, 253', 'Rua 2, 258', 'Rua 3, 789', 'Rua 4, Cep: 897', 'Rua 5, 125']
bedrooms = [2, 3, 4, 1, 2]
bathrooms = [2, 4, 5, 1, 2]
availabilities = [Date.strptime('03-05-2022', '%d-%m-%Y'), Date.strptime('03-05-2022', '%d-%m-%Y'), Date.strptime('03-05-2022', '%d-%m-%Y'), Date.strptime('03-05-2022', '%d-%m-%Y'), Date.strptime('03-05-2022', '%d-%m-%Y')]
prices = [10000, 15000, 10000, 9500, 7000]

images = [
            "app/assets/images/seeds/photo1.jpg",
            "app/assets/images/seeds/photo2.jpg",
            "app/assets/images/seeds/photo3.jpg",
            "app/assets/images/seeds/photo4.jpg",
            "app/assets/images/seeds/photo5.jpg",
          ]

(0..49).each do |number|
   @property = Property.new(
      district: districts[(number % 5)],
      street: streets[(number % 5)],
      bedrooms: bedrooms[(number % 5)],
      bathrooms: bathrooms[(number % 5)],
      availability: availabilities[(number % 5)],
      price: prices[(number % 5)],
   )
   attachable = []
   (0..4).each do |index|
   attachable.push({io: File.open(images[index % 5]),
      filename: "photo#{index+1}.jpg"})
   end
   @property.images.attach(attachable)
   @property.save()
end