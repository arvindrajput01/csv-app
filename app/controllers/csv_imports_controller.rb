class CsvImportsController < ApplicationController
  require 'csv'
  require 'titleize'

  def new
  end

  def create
    file = params[:file]

    CSV.foreach(file.path, headers: true) do |row|
      
      full_name = row["Name"].split(' ')
      first_name = full_name.first
      last_name = full_name.length > 1 ? full_name[1..].join(' ') : ''
      person_data = {
        first_name: first_name.titleize,
        last_name: last_name.titleize,
        weapon: row['Weapon'],
        vehicle: row['Vehicle'],
        species: row['Species'],
        gender: row['Gender']
      }
      
      person = Person.new(person_data)
      next unless person.valid?
      next unless row['Affiliations'].present?
      person.save
      locations = row['Location'].split(',')
      
      affiliations = row['Affiliations'].split(',')
      # locations.each do |location_name|
      #   location = Location.find_or_initialize_by(name: location_name.titleize)
      #   Person.create(person: person, location: location)
      # end

      # affiliations.each do |affiliation_name|
      #   affiliation = Affiliation.find_or_create_by(name: affiliation_name.titleize)
      #   PersonAffiliation.create(person: person, affiliation: affiliation)
      # end
      locations.each do |location_name|
        location = Location.find_or_create_by(location: location_name.titleize)
        person_location = PersonLocation.new(person: person, location: location)
        person_location.save
      end


      # Create or find the Affiliation records
      affiliations.each do |affiliation_name|
        affiliation = Affiliation.find_or_create_by(affiliation: affiliation_name.titleize)

        # Associate person and affiliation through PersonAffiliation
        person_affiliation = PersonAffiliation.new(person: person, affiliation: affiliation)
        person_affiliation.save
      end
      

      
      
    end

       redirect_to people_path, notice: 'CSV data imported successfully.'


    
  end
end
