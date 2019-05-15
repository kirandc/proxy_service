class CreateRequestTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :request_tracks do |t|
      t.text        :url
      t.text        :request_params
      t.text        :request_errors
      t.timestamps
    end
  end
end
