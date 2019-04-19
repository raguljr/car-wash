# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def validate(row)
  if row.nil?
    return ''
  end
  data = row.value
  if data.is_a?(String)
    data = data.gsub("â€“","-")
  end
  data
end

xlsx = Roo::Spreadsheet.open('db/db.xlsx')
sheet = xlsx.sheet(0)
xlsx.each_row_streaming(offset: 1, pad_cells: true) do |row|
  washer = Washer.create(
    name: validate(row[0]),
    short_address: validate(row[1]),
    phone_number: validate(row[2]),
    website: validate(row[3]),
    automatic: validate(row[4]),
    handwash: validate(row[5]),
    touchless: validate(row[6]),
    spray: validate(row[7]),
    interior: validate(row[8]),
    oil_change: validate(row[9]),
    shampoo: validate(row[10]),
    free_vacuum: validate(row[11]),
    google_maps_url: validate(row[12]),
    primary_type: validate(row[13]),
    lat: validate(row[14]),
    lon: validate(row[15]),
    city: validate(row[16]),
    state: validate(row[17]),
    state_code: validate(row[18]),
    zip: validate(row[19]),
    sunday: validate(row[20]),
    monday: validate(row[21]),
    tuesday: validate(row[22]),
    wednesday: validate(row[23]),
    thursday: validate(row[24]),
    friday: validate(row[25]),
    saturday: validate(row[26]),
    secondary_type: validate(row[27])
  )
end