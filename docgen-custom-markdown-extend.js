module.exports = function dataExtend() {
    
    return {
        'contracts/NFTremix.sol': {
            'description': [
                'Lorem ipsum ',
            ].join("<br>"),
            //'constructor':{'custom:shortd': 'part of ERC20'},
            'exclude': [
                //'initialize',
            ],
            'fix': {
                //'renounceOwnership': {'custom:calledby': 'owner', 'custom:shortd': 'leaves contract without owner'},
                
            },
        },
        
    };
}
