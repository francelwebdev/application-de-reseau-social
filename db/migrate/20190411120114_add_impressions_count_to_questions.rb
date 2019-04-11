class AddImpressionsCountToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :impressions_count, :integer
  end
end
