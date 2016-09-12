class RenameTypeToWhatKind < ActiveRecord::Migration
  def change
  	rename_column :notifications, :type, :what_kind
  end
end
