class CreateAffiliations < ActiveRecord::Migration[7.0]
  def change
    create_table :affiliations do |t|
      t.string :affiliation

      t.timestamps
    end
  end
end
