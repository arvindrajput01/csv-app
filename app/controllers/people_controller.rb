class PeopleController < ApplicationController
    helper_method :sort_direction

  def index
    # Sorting
    sort_column = params[:sort] || 'id'
    sort_direction = params[:direction] || 'asc'
    search_params = params[:search]
    page_number = params[:page].to_i.nonzero? || 1
    @people = Person.select('DISTINCT people.id, people.first_name, people.last_name, people.gender, people.species, people.weapon, people.vehicle, locations.location AS location_name, affiliations.affiliation AS affiliation_name')
                .joins(:locations, :affiliations)
                .where(search_conditions(search_params))
                 .order(Arel.sql("#{sort_column} #{sort_direction.upcase}"))
                .paginate(page: page_number, per_page: 10)
  end

  private

    def sort_direction(column)
      column == params[:sort] && params[:direction] == 'asc' ? 'desc' : 'asc'
    end

  def search_conditions(search_params)
    conditions = []
    
    if(search_params)
      search_params.each do |field, value|
        next if value.blank?

        case field
        when 'first_name', 'last_name', 'gender', 'species', 'weapon', 'vehicle'
          conditions << "#{field} LIKE '%#{value}%'"
        when 'location'
          conditions << "locations.location LIKE '%#{value}%'"
        when 'affiliation'
          conditions << "affiliations.affiliation LIKE '%#{value}%'"
        end
      end

      conditions.join(' AND ')
    end
    conditions.join(' AND ')
  end

end

