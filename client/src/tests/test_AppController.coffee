describe 'compose.AppController', ->

  ac    = null
  name  = 'Fatih Acet'
  email = 'acetfatih@gmail.com'
  hash  = md5 email


  beforeEach ->

    localStorage.clear()
    ac = new compose.AppController


  it 'should be instantiated', ->

    expect(ac).toBeDefined()
    expect(ac.router  instanceof compose.Router).toBe  yes
    expect(ac.appView instanceof compose.AppView).toBe yes


  it 'should set account data', ->

    data = { name, email }

    ac.setAccountData data

    expect(ac.account.name).toBe  name
    expect(ac.account.email).toBe email
    expect(ac.account.hash).toBe  hash


  describe '::checkAccount', ->

    it 'should route to welcome page if there is no account data in LS', ->

      expect(page.current).toBe '/welcome'


    it 'should route to app if there is account data in LS', ->

      localStorage.setItem 'account', JSON.stringify { email }

      nac = new compose.AppController
      expect(page.current).toBe '/app'
      expect(nac.account.email).toBe email
