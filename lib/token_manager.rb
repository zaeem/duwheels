module TokenManager

  class TokenStatus
    ACTIVE=1
    N_ACTIVE=0
    NO_LIMIT=0
  end

  def self.todays_token_for(city)
    DealToken.todays_token_for(city)
  end

  def self.side_tokens_for(token_of_day_id)
    if token_of_day_id
    Token.all :conditions=>"id <> (#{token_of_day_id})"
    else
      Token.all
    end
  end

  def self.is_active?(token)
    (token.status==TokenStatus::ACTIVE)?true:false
  end

  def self.is_limit_given?(token)
    (token.maximum_buyers==TokenStatus::NO_LIMIT)?false:true
  end

  def self.total_bought(token)
    Token.find(
      :first,
      :select=>"count(*) as sold_tokens",
      :joins=>"INNER JOIN transactions ON transactions.token_id=tokens.id
            INNER JOIN transaction_histories ON transaction_histories.transaction_id=transactions.id",
      :conditions=>"tokens.id=#{token.id} AND transaction_histories.success=true"
    )['sold_tokens'].to_i
  end

  def self.remaning_tokens_available(token)
    token.maximum_buyers - total_bought(token)
  end

  def self.more_to_buy(token)
    token.minimum_buyers - total_bought(token)
  end

  def self.activate(token)
    
  end
  
#  def self.buy_token(token)
#    token.transactions.create!(:user_id=>current_user.id)
#  end

end
