use cosmwasm_std::{entry_point, DepsMut, Env, MessageInfo, Response, StdResult};
use crate::msg::{InstantiateMsg, ExecuteMsg, QueryMsg};

#[entry_point]
pub fn instantiate(
    deps: DepsMut,
    _env: Env,
    _info: MessageInfo,
    _msg: InstantiateMsg,
) -> StdResult<Response> {
    Ok(Response::default())
}

#[entry_point]
pub fn execute(
    deps: DepsMut,
    _env: Env,
    _info: MessageInfo,
    msg: ExecuteMsg,
) -> StdResult<Response> {
    match msg.action.as_str() {
        "add_points" => {
            // simpan reputasi untuk DID
            // pseudo: reputasi[did] += points
            Ok(Response::new().add_attribute("action", "add_points"))
        }
        _ => Ok(Response::new().add_attribute("action", "noop")),
    }
}

#[entry_point]
pub fn query(
    deps: cosmwasm_std::Deps,
    _env: Env,
    msg: QueryMsg,
) -> StdResult<cosmwasm_std::Binary> {
    // pseudo: return reputasi[did]
    let score: u64 = 100; // dummy
    cosmwasm_std::to_binary(&score)
}
