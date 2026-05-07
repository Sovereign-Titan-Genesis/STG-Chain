use cosmwasm_schema::{cw_serde};

#[cw_serde]
pub struct InstantiateMsg {}

#[cw_serde]
pub struct ExecuteMsg {
    pub action: String,
    pub did: String,
    pub points: u64,
}

#[cw_serde]
pub struct QueryMsg {
    pub did: String,
}
