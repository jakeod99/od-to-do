# For thoughts on Query Object design in Rails:
# https://thoughtbot.com/blog/a-case-for-query-objects-in-rails
# Extend to DRY up repeated complex queries

class ApplicationQuery
  def self.query(scope: nil, filters: {})
    Rails.logger.info "#{name}: Build query with filters " + filters.keys.to_s unless filters.empty?
    if scope
      new(scope: scope).query(filters: filters)
    else
      new.query(filters: filters)
    end
  end

  def self.raw(scope: nil, filters: {}, db_columns: [], return_columns: [])
    Rails.logger.info "#{name}: Pluck with filters " + filters.keys.to_s unless filters.empty?
    if scope
      new(scope: scope).raw(filters: filters, db_columns: db_columns, return_columns: return_columns)
    else
      new.raw(filters: filters, db_columns: db_columns, return_columns: return_columns)
    end
  end

  def initialize(scope: nil)
    raise ArgumentError, "Scope must be ActiveRecord object" unless is_active_record?(scope)
    @scope = scope
  end

  def query(filters: {})
    raise NotImplementedError
  end

  def raw(filters: {}, db_columns: [], return_columns: [])
    raise ArgumentError, "DB Columns array cannot be empty" if db_columns.empty?
    unless valid_column_combination?(db_columns, return_columns)
      raise ArgumentError, "Invalid column array combination"
    end

    return_columns = db_columns if return_columns.empty?

    query(filters: filters)
      .pluck(*db_columns)
      .map do |row|
        Hash[return_columns.zip(row)]
      end
  end

  private

  def is_active_record?(scope)
    scope.class.to_s.split("::").last.split("_").first == "ActiveRecord"
  end

  def valid_column_combination?(db_columns, return_columns)
    db_columns.size == return_columns.size || return_columns.empty?
  end
end
