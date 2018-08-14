require('pg')

class Bounty
  attr_accessor :name, :species, :fav_weapon, :value
  attr_reader :id

  def initialize(options)
    @id = options['id'] if options['id']
    @name = options['name']
    @species = options['species']
    @fav_weapon = options['fav_weapon']
    @value = options['value'].to_i
  end

  def save()
    db = PG.connect({dbname: 'bounties', host: 'localhost'})

    sql = "
      INSERT INTO bounties
        (name, species, fav_weapon, value)
      VALUES
        ($1,$2,$3,$4) RETURNING id;
    "
    values = [@name, @species, @fav_weapon, @value]
    db.prepare('save_new', sql)
    @id = db.exec_prepared('save_new', values)[0]['id'].to_i
    db.close()
  end

  def delete()
    db = PG.connect({dbname: 'bounties', host: 'localhost'})
    sql = "DELETE FROM bounties WHERE id = $1"
    values = [@id]
    db.prepare('delete', sql)
    db.exec_prepared('delete', values)
    db.close() 
  end

  def update()
    db = PG.connect({dbname: 'bounties', host: 'localhost'})
    sql = "
      UPDATE bounties SET
        (
          name, species, fav_weapon, value
        ) = ($1,$2,$3,$4)
      WHERE id = $5;
    "
    values = [@name, @species, @fav_weapon, @value, @id]
    db.prepare('update', sql)
    db.exec_prepared('update', values)
    db.close()
  end

  def Bounty.find_by_name(name)
    db = PG.connect({dbname: 'bounties', host: 'localhost'})
    sql = "SELECT * FROM bounties WHERE name = $1;"
    values = [name]
    db.prepare('find_by_name', sql)
    find_result = db.exec_prepared('find_by_name', values)
    if find_result.num_tuples.zero?
      return nil
    else
      return Bounty.new(find_result[0]) 
    end
    db.close()
  end

  def Bounty.find_by_id(id)
    db = PG.connect({dbname: 'bounties', host: 'localhost'})
    sql = "SELECT * FROM bounties WHERE id = $1;"
    values = [id]
    db.prepare('find_by_id', sql)
    find_result = db.exec_prepared('find_by_id', values)
    if find_result.num_tuples.zero?
      return nil
    else
      return Bounty.new(find_result[0]) 
    end
    db.close()
  end
end
