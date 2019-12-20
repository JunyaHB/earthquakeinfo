class ChangeInformationScaleToInteger < ActiveRecord::Migration[5.1]
  def change
    change_column :information, :scale, 'integer USING CAST(scale AS integer)'
  end
end
